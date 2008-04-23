/* valaccodedynamicmethodbinding.vala
 *
 * Copyright (C) 2007-2008  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.

 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Jürg Billeter <j@bitron.ch>
 */

using GLib;
using Gee;

/**
 * The link between a dynamic method and generated code.
 */
public class Vala.CCodeDynamicMethodBinding : CCodeMethodBinding {
	public CCodeDynamicMethodBinding (CCodeGenerator codegen, DynamicMethod method) {
		this.method = method;
		this.codegen = codegen;
	}

	public void generate_wrapper () {
		var dynamic_method = (DynamicMethod) method;

		var func = new CCodeFunction (method.get_cname (), method.return_type.get_cname ());

		var cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);

		var instance_param = new CCodeFormalParameter ("obj", "gpointer");
		cparam_map.set (codegen.get_param_pos (method.cinstance_parameter_position), instance_param);

		generate_cparameters (method, method.return_type, cparam_map, func);

		var block = new CCodeBlock ();
		if (dynamic_method.dynamic_type.data_type == codegen.dbus_object_type) {
			generate_dbus_method_wrapper (block);
		} else {
			Report.error (method.source_reference, "dynamic methods are not supported for `%s'".printf (dynamic_method.dynamic_type.to_string ()));
		}

		// append to C source file
		codegen.source_type_member_declaration.append (func.copy ());

		func.block = block;
		codegen.source_type_member_definition.append (func);
	}

	void generate_dbus_method_wrapper (CCodeBlock block) {
		var dynamic_method = (DynamicMethod) method;

		var expr = dynamic_method.invocation;

		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_proxy_begin_call"));

		ccall.add_argument (new CCodeIdentifier ("obj"));

		bool found_out = false;
		Expression callback = null;
		int callback_index = -1;
		int arg_index = 1;
		foreach (Expression arg in expr.get_argument_list ()) {
			if (arg.symbol_reference is Method) {
				// callback
				if (callback != null) {
					Report.error (expr.source_reference, "only one reply callback may be specified in invocation of DBus method");
					expr.error = true;
					return;
				} else if (found_out) {
					Report.error (expr.source_reference, "out argument and reply callback conflict in invocation of DBus method");
					expr.error = true;
					return;
				}
				callback = arg;
				callback_index = arg_index;
			} else if (arg is UnaryExpression && ((UnaryExpression) arg).operator == UnaryOperator.OUT) {
				// out arg
				if (callback != null) {
					Report.error (expr.source_reference, "out argument and reply callback conflict in invocation of DBus method");
					expr.error = true;
					return;
				}
				found_out = true;
			} else {
				// in arg
				if (callback != null || found_out) {
					Report.error (expr.source_reference, "in argument must not follow out argument or reply callback in invocation of DBus method");
					expr.error = true;
					return;
				}
			}
			arg_index++;
		}

		ccall.add_argument (new CCodeConstant ("\"%s\"".printf (method.name)));

		if (callback != null) {
			var reply_method = (Method) callback.symbol_reference;

			var cb_fun = new CCodeFunction ("_%s_cb".printf (reply_method.get_cname ()), "void");
			cb_fun.modifiers = CCodeModifiers.STATIC;
			cb_fun.add_parameter (new CCodeFormalParameter ("proxy", "DBusGProxy*"));
			cb_fun.add_parameter (new CCodeFormalParameter ("call", "DBusGProxyCall*"));
			cb_fun.add_parameter (new CCodeFormalParameter ("user_data", "void*"));
			cb_fun.block = new CCodeBlock ();
			var cerrdecl = new CCodeDeclaration ("GError*");
			cerrdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("error", new CCodeConstant ("NULL")));
			cb_fun.block.add_statement (cerrdecl);
			var cend_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_proxy_end_call"));
			cend_call.add_argument (new CCodeIdentifier ("proxy"));
			cend_call.add_argument (new CCodeIdentifier ("call"));
			cend_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("error")));
			var creply_call = new CCodeFunctionCall ((CCodeExpression) callback.ccodenode);
			creply_call.add_argument (new CCodeIdentifier ("user_data"));
			int param_count = reply_method.get_parameters ().size;
			int i = 0;
			foreach (FormalParameter param in reply_method.get_parameters ()) {
				if ((++i) == param_count) {
					// error parameter
					break;
				}
				if (param.type_reference is ArrayType && ((ArrayType) param.type_reference).element_type.data_type != codegen.string_type.data_type) {
					var array_type = (ArrayType) param.type_reference;
					var cdecl = new CCodeDeclaration ("GArray*");
					cdecl.add_declarator (new CCodeVariableDeclarator (param.name));
					cb_fun.block.add_statement (cdecl);
					cend_call.add_argument (get_dbus_array_type (array_type));
					cend_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (param.name)));
					creply_call.add_argument (new CCodeMemberAccess.pointer (new CCodeIdentifier (param.name), "data"));
					creply_call.add_argument (new CCodeMemberAccess.pointer (new CCodeIdentifier (param.name), "len"));
				} else {
					var cdecl = new CCodeDeclaration (param.type_reference.get_cname ());
					cdecl.add_declarator (new CCodeVariableDeclarator (param.name));
					cb_fun.block.add_statement (cdecl);
					if (param.type_reference is ArrayType && ((ArrayType) param.type_reference).element_type.data_type == codegen.string_type.data_type) {
						// special case string array
						cend_call.add_argument (new CCodeIdentifier ("G_TYPE_STRV"));
						var cstrvlen = new CCodeFunctionCall (new CCodeIdentifier ("g_strv_length"));
						cstrvlen.add_argument (new CCodeIdentifier (param.name));
						creply_call.add_argument (cstrvlen);
					} else {
						cend_call.add_argument (new CCodeIdentifier (param.type_reference.data_type.get_type_id ()));
					}
					cend_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (param.name)));
					creply_call.add_argument (new CCodeIdentifier (param.name));
				}
			}
			cend_call.add_argument (new CCodeIdentifier ("G_TYPE_INVALID"));
			cb_fun.block.add_statement (new CCodeExpressionStatement (cend_call));
			creply_call.add_argument (new CCodeIdentifier ("error"));
			cb_fun.block.add_statement (new CCodeExpressionStatement (creply_call));
			codegen.source_type_member_definition.append (cb_fun);

			ccall.add_argument (new CCodeIdentifier (cb_fun.name));
			ccall.add_argument (new CCodeConstant ("param%d_target".printf (callback_index)));
			ccall.add_argument (new CCodeConstant ("NULL"));
		} else if (found_out || !(method.return_type is VoidType)) {
			ccall.call = new CCodeIdentifier ("dbus_g_proxy_call");

			ccall.add_argument (new CCodeIdentifier ("error"));
		} else {
			ccall.call = new CCodeIdentifier ("dbus_g_proxy_call_no_reply");
		}

		foreach (FormalParameter param in method.get_parameters ()) {
			if (param.type_reference is MethodType) {
				// callback parameter
				break;
			}

			ccall.add_argument (new CCodeIdentifier (param.type_reference.data_type.get_type_id ()));
			ccall.add_argument (new CCodeIdentifier (param.name));
		}

		ccall.add_argument (new CCodeIdentifier ("G_TYPE_INVALID"));

		if (!(method.return_type is VoidType)) {
			// synchronous D-Bus method call with reply
			var array_type = method.return_type as ArrayType;
			if (array_type != null && array_type.element_type.data_type != codegen.string_type.data_type) {
				// non-string arrays (use GArray)
				ccall.add_argument (get_dbus_array_type (array_type));

				var garray_type_reference = codegen.get_data_type_for_symbol (codegen.garray_type);
				var cdecl = new CCodeDeclaration (garray_type_reference.get_cname ());
				cdecl.add_declarator (new CCodeVariableDeclarator ("result"));
				block.add_statement (cdecl);

				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("result")));
				ccall.add_argument (new CCodeIdentifier ("G_TYPE_INVALID"));

				block.add_statement (new CCodeExpressionStatement (ccall));

				block.add_statement (new CCodeReturnStatement (new CCodeMemberAccess.pointer (new CCodeIdentifier ("result"), "data")));

				if (!method.no_array_length) {
					expr.append_array_size (new CCodeMemberAccess.pointer (new CCodeIdentifier ("result"), "len"));
				} else {
					expr.append_array_size (new CCodeConstant ("-1"));
				}
			} else {
				// string arrays or other datatypes

				if (method.return_type is ArrayType) {
					// string arrays
					ccall.add_argument (new CCodeIdentifier ("G_TYPE_STRV"));
				} else {
					// other types
					ccall.add_argument (new CCodeIdentifier (method.return_type.data_type.get_type_id ()));
				}

				var cdecl = new CCodeDeclaration (method.return_type.get_cname ());
				cdecl.add_declarator (new CCodeVariableDeclarator ("result"));
				block.add_statement (cdecl);

				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("result")));
				ccall.add_argument (new CCodeIdentifier ("G_TYPE_INVALID"));

				block.add_statement (new CCodeExpressionStatement (ccall));

				block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("result")));

				if (array_type != null) {
					// special case string array
					if (!method.no_array_length) {
						var cstrvlen = new CCodeFunctionCall (new CCodeIdentifier ("g_strv_length"));
						cstrvlen.add_argument (new CCodeIdentifier ("result"));
						expr.append_array_size (cstrvlen);
					} else {
						expr.append_array_size (new CCodeConstant ("-1"));
					}
				}
			}
		} else {
			block.add_statement (new CCodeExpressionStatement (ccall));
		}
	}

	CCodeExpression get_dbus_array_type (ArrayType array_type) {
		var carray_type = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_type_get_collection"));
		carray_type.add_argument (new CCodeConstant ("\"GArray\""));
		carray_type.add_argument (new CCodeIdentifier (array_type.element_type.data_type.get_type_id ()));
		return carray_type;
	}
}