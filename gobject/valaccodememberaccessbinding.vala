/* valaccodememberaccessbinding.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter, Raffaele Sandrini
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
 *	Raffaele Sandrini <raffaele@sandrini.ch>
 */

using GLib;

public class Vala.CCodeMemberAccessBinding : CCodeExpressionBinding {
	public MemberAccess member_access { get; set; }

	public CCodeMemberAccessBinding (CCodeGenerator codegen, MemberAccess member_access) {
		this.member_access = member_access;
		this.codegen = codegen;
	}

	private void process_cmember (MemberAccess expr, CCodeExpression? pub_inst, DataType? base_type) {
		if (expr.symbol_reference is Method) {
			var m = (Method) expr.symbol_reference;
			
			if (expr.inner is BaseAccess) {
				if (m.base_method != null) {
					var base_class = (Class) m.base_method.parent_symbol;
					var vcast = new CCodeFunctionCall (new CCodeIdentifier ("%s_CLASS".printf (base_class.get_upper_case_cname (null))));
					vcast.add_argument (new CCodeIdentifier ("%s_parent_class".printf (codegen.current_class.get_lower_case_cname (null))));
					
					expr.ccodenode = new CCodeMemberAccess.pointer (vcast, m.name);
					return;
				} else if (m.base_interface_method != null) {
					var base_iface = (Interface) m.base_interface_method.parent_symbol;
					string parent_iface_var = "%s_%s_parent_iface".printf (codegen.current_class.get_lower_case_cname (null), base_iface.get_lower_case_cname (null));

					expr.ccodenode = new CCodeMemberAccess.pointer (new CCodeIdentifier (parent_iface_var), m.name);
					return;
				}
			}
			
			if (m.base_method != null) {
				var binding = method_binding (m.base_method);
				if (!binding.has_wrapper) {
					var inst = pub_inst;
					if (expr.inner != null && !expr.inner.is_pure ()) {
						// instance expression has side-effects
						// store in temp. variable
						var temp_var = codegen.get_temp_variable (expr.inner.static_type);
						codegen.temp_vars.insert (0, temp_var);
						var ctemp = new CCodeIdentifier (temp_var.name);
						inst = new CCodeAssignment (ctemp, pub_inst);
						expr.inner.ccodenode = ctemp;
					}
					var base_class = (Class) m.base_method.parent_symbol;
					var vclass = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_CLASS".printf (base_class.get_upper_case_cname (null))));
					vclass.add_argument (inst);
					expr.ccodenode = new CCodeMemberAccess.pointer (vclass, m.name);
				} else {
					expr.ccodenode = new CCodeIdentifier (m.base_method.get_cname ());
				}
			} else if (m.base_interface_method != null) {
				expr.ccodenode = new CCodeIdentifier (m.base_interface_method.get_cname ());
			} else {
				expr.ccodenode = new CCodeIdentifier (m.get_cname ());
			}
		} else if (expr.symbol_reference is ArrayLengthField) {
			expr.ccodenode = codegen.get_array_length_cexpression (expr.inner, 1);
		} else if (expr.symbol_reference is Field) {
			var f = (Field) expr.symbol_reference;
			if (f.instance) {
				var instance_expression_type = base_type;
				var instance_target_type = codegen.get_data_type_for_symbol ((Typesymbol) f.parent_symbol);
				CCodeExpression typed_inst = codegen.get_implicit_cast_expression (pub_inst, instance_expression_type, instance_target_type);

				bool is_gtypeinstance = (instance_target_type.data_type.is_subtype_of (codegen.gtypeinstance_type));

				CCodeExpression inst;
				if (is_gtypeinstance && f.access == SymbolAccessibility.PRIVATE) {
					inst = new CCodeMemberAccess.pointer (typed_inst, "priv");
				} else {
					inst = typed_inst;
				}
				if (instance_target_type.data_type.is_reference_type () || (expr.inner != null && expr.inner.static_type is PointerType)) {
					expr.ccodenode = new CCodeMemberAccess.pointer (inst, f.get_cname ());
				} else {
					expr.ccodenode = new CCodeMemberAccess (inst, f.get_cname ());
				}
			} else {
				expr.ccodenode = new CCodeIdentifier (f.get_cname ());
			}

			if (f.type_reference.type_parameter != null && expr.static_type.type_parameter == null) {
				expr.ccodenode = codegen.convert_from_generic_pointer ((CCodeExpression) expr.ccodenode, expr.static_type);
			}
		} else if (expr.symbol_reference is Constant) {
			var c = (Constant) expr.symbol_reference;
			expr.ccodenode = new CCodeIdentifier (c.get_cname ());
		} else if (expr.symbol_reference is Property) {
			var prop = (Property) expr.symbol_reference;

			if (prop.get_accessor != null &&
			    prop.get_accessor.automatic_body &&
			    codegen.current_type_symbol == prop.parent_symbol) {
				CCodeExpression inst;
				inst = new CCodeMemberAccess.pointer (pub_inst, "priv");
				expr.ccodenode = new CCodeMemberAccess.pointer (inst, prop.field.get_cname());
			} else if (!prop.no_accessor_method) {
				var base_property = prop;
				if (prop.base_property != null) {
					base_property = prop.base_property;
				} else if (prop.base_interface_property != null) {
					base_property = prop.base_interface_property;
				}
				var base_property_type = (Typesymbol) base_property.parent_symbol;
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("%s_get_%s".printf (base_property_type.get_lower_case_cname (null), base_property.name)));

				var instance_expression_type = base_type;
				var instance_target_type = codegen.get_data_type_for_symbol (base_property_type);
				CCodeExpression typed_pub_inst = codegen.get_implicit_cast_expression (pub_inst, instance_expression_type, instance_target_type);

				ccall.add_argument (typed_pub_inst);

				// Property acesses to real struct types are handeled different to other properties.
				// They are returned as out parameter.
				if (base_property.type_reference.is_real_struct_type ()) {
					var ccomma = new CCodeCommaExpression ();
					var temp_var = codegen.get_temp_variable (base_property.type_reference);
					var ctemp = new CCodeIdentifier (temp_var.name);
					codegen.temp_vars.add (temp_var);
					ccall.add_argument (new CCodeUnaryExpression(CCodeUnaryOperator.ADDRESS_OF, ctemp));
					ccomma.append_expression (ccall);
					ccomma.append_expression (ctemp);
					expr.ccodenode = ccomma;
				} else {
					expr.ccodenode = ccall;
				}
			} else {
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_object_get"));
			
				var ccast = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT"));
				ccast.add_argument (pub_inst);
				ccall.add_argument (ccast);
				
				// property name is second argument of g_object_get
				ccall.add_argument (prop.get_canonical_cconstant ());
				
				
				// we need a temporary variable to save the property value
				var temp_var = codegen.get_temp_variable (expr.static_type);
				codegen.temp_vars.insert (0, temp_var);

				var ctemp = new CCodeIdentifier (temp_var.name);
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, ctemp));
				
				
				ccall.add_argument (new CCodeConstant ("NULL"));
				
				var ccomma = new CCodeCommaExpression ();
				ccomma.append_expression (ccall);
				ccomma.append_expression (ctemp);
				expr.ccodenode = ccomma;
			}
		} else if (expr.symbol_reference is EnumValue) {
			var ev = (EnumValue) expr.symbol_reference;
			expr.ccodenode = new CCodeConstant (ev.get_cname ());
		} else if (expr.symbol_reference is LocalVariable) {
			var local = (LocalVariable) expr.symbol_reference;
			expr.ccodenode = new CCodeIdentifier (codegen.get_variable_cname (local.name));
		} else if (expr.symbol_reference is FormalParameter) {
			var p = (FormalParameter) expr.symbol_reference;
			if (p.name == "this") {
				expr.ccodenode = pub_inst;
			} else {
				var type_as_struct = p.type_reference.data_type as Struct;
				if (p.direction != ParameterDirection.IN
				    || (type_as_struct != null && !type_as_struct.is_simple_type ())) {
					expr.ccodenode = new CCodeIdentifier ("(*%s)".printf (p.name));
				} else {
					// Property setters of non simple structs shall replace all occurences
					// of the "value" formal parameter with a dereferencing version of that
					// parameter.
					if (codegen.current_property_accessor != null &&
					    codegen.current_property_accessor.writable &&
					    codegen.current_property_accessor.value_parameter == p &&
					    codegen.current_property_accessor.prop.type_reference.is_real_struct_type ()) {
						expr.ccodenode = new CCodeIdentifier ("(*value)");
					} else {
						expr.ccodenode = new CCodeIdentifier (p.name);
					}
				}
			}
		} else if (expr.symbol_reference is Signal) {
			var sig = (Signal) expr.symbol_reference;
			var cl = (Typesymbol) sig.parent_symbol;
			
			if (sig.has_emitter) {
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("%s_%s".printf (cl.get_lower_case_cname (null), sig.name)));
				var instance_expression_type = base_type;
				var instance_target_type = codegen.get_data_type_for_symbol (cl);
				CCodeExpression typed_pub_inst = codegen.get_implicit_cast_expression (pub_inst, instance_expression_type, instance_target_type);

				ccall.add_argument (typed_pub_inst);
				expr.ccodenode = ccall;
			} else {
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_signal_emit_by_name"));

				// FIXME: use C cast if debugging disabled
				var ccast = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT"));
				ccast.add_argument (pub_inst);
				ccall.add_argument (ccast);

				ccall.add_argument (sig.get_canonical_cconstant ());
				
				expr.ccodenode = ccall;
			}
		}
	}

	public override void emit () {
		var expr = member_access;

		CCodeExpression pub_inst = null;
		DataType base_type = null;
	
		if (expr.inner == null) {
			pub_inst = new CCodeIdentifier ("self");

			if (codegen.current_type_symbol != null) {
				/* base type is available if this is a type method */
				if (codegen.current_type_symbol is Class) {
					base_type = new ClassType ((Class) codegen.current_type_symbol);
				} else if (codegen.current_type_symbol is Interface) {
					base_type = new InterfaceType ((Interface) codegen.current_type_symbol);
				} else {
					base_type = new ValueType (codegen.current_type_symbol);
					pub_inst = new CCodeIdentifier ("(*self)");
				}
			}
		} else {
			pub_inst = (CCodeExpression) expr.inner.ccodenode;

			if (expr.inner.static_type != null) {
				base_type = expr.inner.static_type;
			}
		}

		process_cmember (expr, pub_inst, base_type);

		codegen.visit_expression (expr);
	}
}
