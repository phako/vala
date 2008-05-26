/* valavaluetype.vala
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

/**
 * A value type, i.e. a struct or an enum type.
 */
public class Vala.ValueType : DataType {
	/**
	 * The referred struct or enum.
	 */
	public weak TypeSymbol type_symbol { get; set; }

	public ValueType (TypeSymbol type_symbol) {
		this.type_symbol = type_symbol;
		data_type = type_symbol;
	}

	public override DataType copy () {
		var result = new ValueType (type_symbol);
		result.source_reference = source_reference;
		result.value_owned = value_owned;
		result.nullable = nullable;
		result.is_dynamic = is_dynamic;
		result.floating_reference = floating_reference;
		
		foreach (DataType arg in get_type_arguments ()) {
			result.add_type_argument (arg.copy ());
		}
		
		return result;
	}

	public override string? get_cname () {
		string ptr = "";
		if (nullable) {
			ptr = "*";
		}
		return type_symbol.get_cname () + ptr;
	}
}
