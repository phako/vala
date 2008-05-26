/* valaccodeobjecttypesymbolbinding.vala
 *
 * Copyright (C) 2008  Philip Van Hoof
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
 * 	Philip Van Hoof <pvanhoof@gnome.org>
 */

using GLib;

public abstract class Vala.CCodeObjectTypesymbolBinding : Vala.CCodeTypesymbolBinding {

	bool is_dbus_visible (CodeNode node) {
		var dbus_attribute = node.get_attribute ("DBus");
		if (dbus_attribute != null
		    && dbus_attribute.has_argument ("visible")
		    && !dbus_attribute.get_bool ("visible")) {
			return false;
		}

		return true;
	}

	public CCodeFragment register_dbus_info (ObjectTypesymbol bindable) {

		CCodeFragment fragment = new CCodeFragment ();

		var dbus = bindable.get_attribute ("DBus");
		if (dbus == null) {
			return fragment;
		}
		var dbus_iface_name = dbus.get_string ("name");
		if (dbus_iface_name == null) {
			return fragment;
		}

		codegen.dbus_glib_h_needed = true;

		var dbus_methods = new StringBuilder ();
		dbus_methods.append ("{\n");

		var blob = new StringBuilder ();
		blob.append_c ('"');

		int method_count = 0;
		long blob_len = 0;
		foreach (Method m in bindable.get_methods ()) {
			if (m is CreationMethod || m.binding != MemberBinding.INSTANCE
			    || m.overrides || m.access != SymbolAccessibility.PUBLIC) {
				continue;
			}
			if (!is_dbus_visible (m)) {
				continue;
			}

			var parameters = new Gee.ArrayList<FormalParameter> ();
			foreach (FormalParameter param in m.get_parameters ()) {
				parameters.add (param);
			}
			if (!(m.return_type is VoidType)) {
				parameters.add (new FormalParameter ("result", new PointerType (new VoidType ())));
			}
			parameters.add (new FormalParameter ("error", codegen.gerror_type));

			dbus_methods.append ("{ (GCallback) ");
			dbus_methods.append (generate_dbus_wrapper (m, bindable));
			dbus_methods.append (", ");
			dbus_methods.append (codegen.get_marshaller_function (parameters, codegen.bool_type));
			dbus_methods.append (", ");
			dbus_methods.append (blob_len.to_string ());
			dbus_methods.append (" },\n");

			codegen.generate_marshaller (parameters, codegen.bool_type);

			long start = blob.len;

			blob.append (dbus_iface_name);
			blob.append ("\\0");
			start++;

			blob.append (m.name);
			blob.append ("\\0");
			start++;

			// synchronous
			blob.append ("S\\0");
			start++;

			foreach (FormalParameter param in m.get_parameters ()) {
				blob.append (param.name);
				blob.append ("\\0");
				start++;

				if (param.direction == ParameterDirection.IN) {
					blob.append ("I\\0");
					start++;
				} else if (param.direction == ParameterDirection.OUT) {
					blob.append ("O\\0");
					start++;
					blob.append ("F\\0");
					start++;
					blob.append ("N\\0");
					start++;
				} else {
					Report.error (param.source_reference, "unsupported parameter direction for D-Bus method");
				}

				blob.append (param.parameter_type.get_type_signature ());
				blob.append ("\\0");
				start++;
			}

			if (!(m.return_type is VoidType)) {
				blob.append ("result\\0");
				start++;

				blob.append ("O\\0");
				start++;
				blob.append ("F\\0");
				start++;
				blob.append ("N\\0");
				start++;

				blob.append (m.return_type.get_type_signature ());
				blob.append ("\\0");
				start++;
			}

			blob.append ("\\0");
			start++;

			blob_len += blob.len - start;

			method_count++;
		}

		blob.append_c ('"');

		dbus_methods.append ("}\n");

		var dbus_signals = new StringBuilder ();
		dbus_signals.append_c ('"');
		foreach (Signal sig in bindable.get_signals ()) {
			if (sig.access != SymbolAccessibility.PUBLIC) {
				continue;
			}
			if (!is_dbus_visible (sig)) {
				continue;
			}

			dbus_signals.append (dbus_iface_name);
			dbus_signals.append ("\\0");
			dbus_signals.append (sig.name);
			dbus_signals.append ("\\0");
		}
		dbus_signals.append_c('"');

		var dbus_props = new StringBuilder();
		dbus_props.append_c ('"');
		foreach (Property prop in bindable.get_properties ()) {
			if (prop.access != SymbolAccessibility.PUBLIC) {
				continue;
			}
			if (!is_dbus_visible (prop)) {
				continue;
			}

			dbus_props.append (dbus_iface_name);
			dbus_props.append ("\\0");
			dbus_props.append (prop.name);
			dbus_props.append ("\\0");
		}
		dbus_props.append_c ('"');

		var dbus_methods_decl = new CCodeDeclaration ("const DBusGMethodInfo");
		dbus_methods_decl.modifiers = CCodeModifiers.STATIC;
		dbus_methods_decl.add_declarator (new CCodeVariableDeclarator.with_initializer ("%s_dbus_methods[]".printf (bindable.get_lower_case_cname ()), new CCodeConstant (dbus_methods.str)));

		fragment.append (dbus_methods_decl);

		var dbus_object_info = new CCodeDeclaration ("const DBusGObjectInfo");
		dbus_object_info.modifiers = CCodeModifiers.STATIC;
		dbus_object_info.add_declarator (new CCodeVariableDeclarator.with_initializer ("%s_dbus_object_info".printf (bindable.get_lower_case_cname ()), new CCodeConstant ("{ 0, %s_dbus_methods, %d, %s, %s, %s }".printf (bindable.get_lower_case_cname (), method_count, blob.str, dbus_signals.str, dbus_props.str))));

		fragment.append (dbus_object_info);

		var install_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_object_type_install_info"));
		install_call.add_argument (new CCodeIdentifier (bindable.get_type_id ()));
		install_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("%s_dbus_object_info".printf (bindable.get_lower_case_cname ()))));

		fragment.append (new CCodeExpressionStatement (install_call));

		return fragment;
	}

	string generate_dbus_wrapper (Method m, ObjectTypesymbol bindable) {
		string wrapper_name = "_dbus_%s".printf (m.get_cname ());

		// declaration

		var function = new CCodeFunction (wrapper_name, "gboolean");
		function.modifiers = CCodeModifiers.STATIC;
		m.ccodenode = function;

		function.add_parameter (new CCodeFormalParameter ("self", bindable.get_cname () + "*"));

		foreach (FormalParameter param in m.get_parameters ()) {
			function.add_parameter ((CCodeFormalParameter) param.ccodenode);
		}

		if (!(m.return_type is VoidType)) {
			function.add_parameter (new CCodeFormalParameter ("result", m.return_type.get_cname () + "*"));
		}

		function.add_parameter (new CCodeFormalParameter ("error", "GError**"));

		// definition

		var ccall = new CCodeFunctionCall (new CCodeIdentifier (m.get_cname ()));

		ccall.add_argument (new CCodeIdentifier ("self"));

		foreach (FormalParameter param in m.get_parameters ()) {
			ccall.add_argument (new CCodeIdentifier (param.name));
		}

		if (m.get_error_types ().size > 0) {
			ccall.add_argument (new CCodeIdentifier ("error"));
		}

		CCodeExpression expr;
		if (m.return_type is VoidType) {
			expr = ccall;
		} else {
			expr = new CCodeAssignment (new CCodeIdentifier ("*result"), ccall);
		}

		var block = new CCodeBlock ();
		block.add_statement (new CCodeExpressionStatement (expr));
		var no_error = new CCodeBinaryExpression (CCodeBinaryOperator.OR, new CCodeIdentifier ("!error"), new CCodeIdentifier ("!*error"));
		block.add_statement (new CCodeReturnStatement (no_error));

		// append to file

		codegen.source_type_member_declaration.append (function.copy ());

		function.block = block;
		codegen.source_type_member_definition.append (function);

		return wrapper_name;
	}
}