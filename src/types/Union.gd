class_name Union
extends Node

var permitted_types: Array[Variant.Type]
var value: Variant:
	get:
		return value
	set(value_):
		_validate_variant_type(value_)
		value = value_

func _init(value_: Variant, permitted_types_: Array[Variant.Type]):
	permitted_types = permitted_types_
	value = value_

func _validate_variant_type(value_: Variant) -> Error:
	if typeof(value_) in permitted_types:
		push_error("%s is not a one of the legal variant types." % typeof(value_))
		return Error.ERR_INVALID_PARAMETER
		
	return Error.OK

func is_null() -> bool:
	return typeof(value) == Variant.Type.TYPE_NIL
