/* valainterfacewriter.vala
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
 *	Raffaele Sandrini <rasa@gmx.ch>
 */

using GLib;
using Gee;

/**
 * Code visitor generating Vala API file for the public interface.
 */
public class Vala.InterfaceWriter : CodeVisitor {
	private CodeContext context;
	
	FileStream stream;
	
	int indent;
	/* at begin of line */
	bool bol = true;

	string current_cheader_filename;

	/**
	 * Writes the public interface of the specified code context into the
	 * specified file.
	 *
	 * @param context  a code context
	 * @param filename a relative or absolute filename
	 */
	public void write_file (CodeContext! context, string! filename) {
		this.context = context;
	
		stream = FileStream.open (filename, "w");

		write_string ("/* %s generated by %s, do not modify. */".printf (Path.get_basename (filename), Environment.get_prgname ()));
		write_newline ();
		write_newline ();

		context.accept (this);
		
		stream = null;
	}

	public override void visit_namespace (Namespace! ns) {
		if (ns.pkg) {
			return;
		}

		if (ns.name == null)  {
			ns.accept_children (this);
			return;
		}

		write_indent ();
		write_string ("[CCode (cprefix = \"%s\", lower_case_cprefix = \"%s\")]".printf (ns.get_cprefix (), ns.get_lower_case_cprefix ()));
		write_newline ();

		write_indent ();
		write_string ("namespace ");
		write_identifier (ns.name);
		write_begin_block ();

		ns.accept_children (this);

		write_end_block ();
		write_newline ();
	}

	public override void visit_class (Class! cl) {
		if (cl.source_reference != null && cl.source_reference.file.pkg) {
			return;
		}

		if (!check_accessibility (cl)) {
			return;
		}
		
		write_indent ();
		
		var first = true;
		string cheaders;
		foreach (string cheader in cl.get_cheader_filenames ()) {
			if (first) {
				cheaders = cheader;
				first = false;
			} else {
				cheaders = "%s,%s".printf (cheaders, cheader);
			}
		}
		write_string ("[CCode (");

		if (cl.is_reference_counting ()) {
			if (cl.base_class == null || cl.base_class.get_ref_function () == null || cl.base_class.get_ref_function () != cl.get_ref_function ()) {
				write_string ("ref_function = \"%s\", ".printf (cl.get_ref_function ()));
			}
			if (cl.base_class == null || cl.base_class.get_unref_function () == null || cl.base_class.get_unref_function () != cl.get_unref_function ()) {
				write_string ("unref_function = \"%s\", ".printf (cl.get_unref_function ()));
			}
		} else {
			if (cl.get_dup_function () != null) {
				write_string ("copy_function = \"%s\", ".printf (cl.get_dup_function ()));
			}
			if (cl.get_free_function () != cl.get_default_free_function ()) {
				write_string ("free_function = \"%s\", ".printf (cl.get_free_function ()));
			}
		}

		if (cl.get_cname () != cl.get_default_cname ()) {
			write_string ("cname = \"%s\", ".printf (cl.get_cname ()));
		}

		write_string ("cheader_filename = \"%s\")]".printf (cheaders));
		write_newline ();
		
		write_indent ();
		write_accessibility (cl);
		if (cl.is_static) {
			write_string ("static ");
		} else if (cl.is_abstract) {
			write_string ("abstract ");
		}
		write_string ("class ");
		write_identifier (cl.name);

		var type_params = cl.get_type_parameters ();
		if (type_params.size > 0) {
			write_string ("<");
			bool first = true;
			foreach (TypeParameter type_param in type_params) {
				if (first) {
					first = false;
				} else {
					write_string (",");
				}
				write_identifier (type_param.name);
			}
			write_string (">");
		}

		var base_types = cl.get_base_types ();
		if (base_types.size > 0) {
			write_string (" : ");
		
			bool first = true;
			foreach (DataType base_type in base_types) {
				if (!first) {
					write_string (", ");
				} else {
					first = false;
				}
				write_type (base_type);
			}
		}
		write_begin_block ();

		cl.accept_children (this);

		write_end_block ();
		write_newline ();
	}

	public override void visit_struct (Struct! st) {
		if (st.source_reference != null && st.source_reference.file.pkg) {
			return;
		}

		if (!check_accessibility (st)) {
			return;
		}
		
		write_indent ();

		var first = true;
		string cheaders;
		foreach (string cheader in st.get_cheader_filenames ()) {
			if (first) {
				cheaders = cheader;
				first = false;
			} else {
				cheaders = "%s,%s".printf (cheaders, cheader);
			}
		}
		write_string ("[CCode (cheader_filename = \"%s\")]".printf (cheaders));
		write_newline ();

		if (st.is_simple_type ()) {
			write_indent ();
			write_string ("[SimpleType]");
			write_newline ();
		}

		write_indent ();
		write_accessibility (st);
		write_string ("struct ");
		write_identifier (st.name);
		write_begin_block ();

		st.accept_children (this);

		write_end_block ();
		write_newline ();
	}

	public override void visit_interface (Interface! iface) {
		if (iface.source_reference != null && iface.source_reference.file.pkg) {
			return;
		}

		if (!check_accessibility (iface)) {
			return;
		}

		write_indent ();

		var first = true;
		string cheaders;
		foreach (string cheader in iface.get_cheader_filenames ()) {
			if (first) {
				cheaders = cheader;
				first = false;
			} else {
				cheaders = "%s,%s".printf (cheaders, cheader);
			}
		}
		write_string ("[CCode (cheader_filename = \"%s\")]".printf (cheaders));
		write_newline ();

		write_indent ();
		write_accessibility (iface);
		write_string ("interface ");
		write_identifier (iface.name);

		var type_params = iface.get_type_parameters ();
		if (type_params.size > 0) {
			write_string ("<");
			bool first = true;
			foreach (TypeParameter type_param in type_params) {
				if (first) {
					first = false;
				} else {
					write_string (",");
				}
				write_identifier (type_param.name);
			}
			write_string (">");
		}

		var prerequisites = iface.get_prerequisites ();
		if (prerequisites.size > 0) {
			write_string (" : ");
		
			bool first = true;
			foreach (DataType prerequisite in prerequisites) {
				if (!first) {
					write_string (", ");
				} else {
					first = false;
				}
				write_type (prerequisite);
			}
		}
		write_begin_block ();

		iface.accept_children (this);

		write_end_block ();
		write_newline ();
	}

	public override void visit_enum (Enum! en) {
		if (en.source_reference != null && en.source_reference.file.pkg) {
			return;
		}

		if (!check_accessibility (en)) {
			return;
		}

		write_indent ();

		var first = true;
		string cheaders;
		foreach (string cheader in en.get_cheader_filenames ()) {
			if (first) {
				cheaders = cheader;
				first = false;
			} else {
				cheaders = "%s,%s".printf (cheaders, cheader);
			}
		}
		write_string ("[CCode (cprefix = \"%s\", cheader_filename = \"%s\")]".printf (en.get_cprefix (), cheaders));

		if (en.is_flags) {
			write_indent ();
			write_string ("[Flags]");
		}
		if (en.error_domain) {
			write_indent ();
			write_string ("[ErrorDomain]");
		}

		write_indent ();
		write_accessibility (en);
		write_string ("enum ");
		write_identifier (en.name);
		write_begin_block ();

		en.accept_children (this);

		write_end_block ();
		write_newline ();
	}

	public override void visit_enum_value (EnumValue! ev) {
		write_indent ();
		write_identifier (ev.name);
		write_string (",");
		write_newline ();
	}

	public override void visit_constant (Constant! c) {
		if (c.source_reference != null && c.source_reference.file.pkg) {
			return;
		}

		if (!check_accessibility (c)) {
			return;
		}

		write_indent ();
		write_accessibility (c);
		write_string ("const ");

		write_type (c.type_reference);
			
		write_string (" ");
		write_identifier (c.name);
		write_string (";");
		write_newline ();
	}

	public override void visit_field (Field! f) {
		if (f.source_reference != null && f.source_reference.file.pkg) {
			return;
		}

		if (!check_accessibility (f)) {
			return;
		}

		if (f.get_cname () != f.get_default_cname ()) {
			write_indent ();
			write_string ("[CCode (cname = \"%s\")]".printf (f.get_cname ()));
		}

		write_indent ();
		write_accessibility (f);

		if (f.type_reference.data_type != null &&
		    f.type_reference.data_type.is_reference_type () &&
		    !f.type_reference.takes_ownership) {
			write_string ("weak ");
		}

		write_type (f.type_reference);
			
		write_string (" ");
		write_identifier (f.name);
		write_string (";");
		write_newline ();
	}
	
	private void write_error_domains (Collection<DataType> error_domains) {
		if (error_domains.size > 0) {
			write_string (" throws ");

			bool first = true;
			foreach (DataType type in error_domains) {
				if (!first) {
					write_string (", ");
				} else {
					first = false;
				}

				write_type (type);
			}
		}
	}

	private void write_params (Collection<FormalParameter> params) {
		write_string ("(");

		bool first = true;
		foreach (FormalParameter param in params) {
			if (!first) {
				write_string (", ");
			} else {
				first = false;
			}
			
			if (param.ellipsis) {
				write_string ("...");
				continue;
			}
			
			if (param.type_reference.is_ref || param.type_reference.is_out) {
				if (param.type_reference.is_ref) {
					write_string ("ref ");
				} else if (param.type_reference.is_out) {
					write_string ("out ");
				}
				if (param.type_reference.data_type != null && param.type_reference.data_type.is_reference_type () && !param.type_reference.takes_ownership) {
					write_string ("weak ");
				}
			}

			write_type (param.type_reference);

			if (param.type_reference.transfers_ownership) {
				write_string ("#");
			}

			write_string (" ");
			write_identifier (param.name);
			
			if (param.default_expression != null) {
				write_string (" = ");
				write_string (param.default_expression.to_string ());
			}
		}

		write_string (")");
	}

	public override void visit_delegate (Delegate! cb) {
		if (cb.source_reference != null && cb.source_reference.file.pkg) {
			return;
		}

		if (!check_accessibility (cb)) {
			return;
		}
		
		write_indent ();
		write_accessibility (cb);
		write_string ("static delegate ");
		
		write_return_type (cb.return_type);
		
		write_string (" ");
		write_identifier (cb.name);
		
		write_string (" ");
		
		write_params (cb.get_parameters ());

		write_string (";");

		write_newline ();
	}

	public override void visit_method (Method! m) {
		if (m.source_reference != null && m.source_reference.file.pkg) {
			return;
		}

		if (!check_accessibility (m) || m.overrides) {
			return;
		}
		
		if (m.no_array_length) {
			bool array_found = (m.return_type != null && m.return_type.data_type is Array);
			foreach (FormalParameter param in m.get_parameters ()) {
				if (param.type_reference != null && param.type_reference.data_type is Array) {
					array_found = true;
					break;
				}
			}
			if (array_found) {
				write_indent ();
				write_string ("[NoArrayLength]");
			}
		}
		if (m.instance_last) {
			write_indent ();
			write_string ("[InstanceLast]");
		}

		var ccode_params = new String ();
		var separator = "";

		if (m.get_cname () != m.get_default_cname ()) {
			ccode_params.append_printf ("%scname = \"%s\"", separator, m.get_cname ());
			separator = ", ";
		}
		if (m.sentinel != m.DEFAULT_SENTINEL) {
			ccode_params.append_printf ("%ssentinel = \"%s\"", separator, m.sentinel);
			separator = ", ";
		}

		if (ccode_params.len > 0) {
			write_indent ();
			write_string ("[CCode (%s)]".printf (ccode_params.str));
		}
		
		write_indent ();
		write_accessibility (m);
		
		if (m is CreationMethod) {
			var datatype = (Typesymbol) m.parent_symbol;
			write_identifier (datatype.name);
			write_identifier (m.name.offset (".new".len ()));
			write_string (" ");
		} else if (!m.instance) {
			write_string ("static ");
		} else if (m.is_abstract) {
			write_string ("abstract ");
		} else if (m.is_virtual) {
			write_string ("virtual ");
		}
		
		if (!(m is CreationMethod)) {
			write_return_type (m.return_type);
			write_string (" ");

			write_identifier (m.name);
			write_string (" ");
		}
		
		write_params (m.get_parameters ());
		write_error_domains (m.get_error_domains ());

		write_string (";");

		write_newline ();
	}
	
	public override void visit_creation_method (CreationMethod! m) {
		visit_method (m);
	}

	public override void visit_property (Property! prop) {
		if (!check_accessibility (prop)) {
			return;
		}

		if (prop.no_accessor_method) {
			write_indent ();
			write_string ("[NoAccessorMethod]");
		}
		
		write_indent ();
		write_accessibility (prop);

		if (prop.is_abstract) {
			write_string ("abstract ");
		} else if (prop.is_virtual) {
			write_string ("virtual ");
		}
		if (!prop.type_reference.takes_ownership) {
			write_string ("weak ");
		}

		write_type (prop.type_reference);
			
		write_string (" ");
		write_identifier (prop.name);
		write_string (" {");
		if (prop.get_accessor != null) {
			write_string (" get;");
		}
		if (prop.set_accessor != null) {
			if (prop.set_accessor.writable) {
				write_string (" set");
			}
			if (prop.set_accessor.construction) {
				write_string (" construct");
			}
			write_string (";");
		}
		write_string (" }");
		write_newline ();
	}

	public override void visit_signal (Signal! sig) {
		if (!check_accessibility (sig)) {
			return;
		}
		
		if (sig.has_emitter) {
			write_indent ();
			write_string ("[HasEmitter]");
		}
		
		write_indent ();
		write_accessibility (sig);
		write_string ("signal ");
		
		write_return_type (sig.return_type);
		
		write_string (" ");
		write_identifier (sig.name);
		
		write_string (" ");
		
		write_params (sig.get_parameters ());

		write_string (";");

		write_newline ();
	}

	private void write_indent () {
		int i;
		
		if (!bol) {
			stream.putc ('\n');
		}
		
		for (i = 0; i < indent; i++) {
			stream.putc ('\t');
		}
		
		bol = false;
	}
	
	private void write_identifier (string! s) {
		if (s == "base" || s == "break" || s == "class" ||
		    s == "construct" || s == "delegate" || s == "do" ||
		    s == "foreach" || s == "in" || s == "interface" ||
		    s == "lock" || s == "namespace" || s == "new" ||
		    s == "out" || s == "ref" || s == "signal") {
			stream.putc ('@');
		}
		write_string (s);
	}

	private void write_return_type (DataType! type) {
		if ((type.data_type != null && type.data_type.is_reference_type ()) || type.type_parameter != null) {
			if (!type.transfers_ownership) {
				write_string ("weak ");
			}
		}

		write_type (type);
	}

	private void write_type (DataType! type) {
		write_string (type.to_string ());
	}

	private void write_string (string! s) {
		stream.printf ("%s", s);
		bol = false;
	}
	
	private void write_newline () {
		stream.putc ('\n');
		bol = true;
	}
	
	private void write_begin_block () {
		if (!bol) {
			stream.putc (' ');
		} else {
			write_indent ();
		}
		stream.putc ('{');
		write_newline ();
		indent++;
	}
	
	private void write_end_block () {
		indent--;
		write_indent ();
		stream.printf ("}");
	}

	private bool check_accessibility (Symbol! sym) {
		if (sym.access == SymbolAccessibility.PUBLIC ||
		    sym.access == SymbolAccessibility.PROTECTED) {
			return true;
		}

		return false;
	}

	private void write_accessibility (Symbol! sym) {
		if (sym.access == SymbolAccessibility.PUBLIC) {
			write_string ("public ");
		} else if (sym.access == SymbolAccessibility.PROTECTED) {
			write_string ("protected ");
		} else {
			assert_not_reached ();
		}
	}
}
