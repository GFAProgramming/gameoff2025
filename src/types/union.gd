class_name Union
extends Node

var _permitted_types: Array[Variant.Type]
var _value: Variant

func get_value() -> Variant:
	return _value
	
func set_value(value_: Variant) -> void:
	_validate_type(value_)
	_value = value_
	
func permits_assignment_of_type(type: Variant.Type) -> bool:
	return type in _permitted_types

func is_null() -> bool:
	return typeof(_value) == Variant.Type.TYPE_NIL
	
func _init(value_: Variant, permitted_types_: Array[Variant.Type]):
	_permitted_types = permitted_types_
	set_value(value_)

func _validate_type(value_: Variant) -> Error:
	if not typeof(value_) in _permitted_types:
		push_error("%s is not a one of the legal Union types.")
		return Error.ERR_INVALID_PARAMETER
		
	return Error.OK
