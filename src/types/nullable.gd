class_name Nullable
extends Node

var _value_or_null: Union
var _permitted_type: Variant.Type

func _init(value_: Variant, permitted_type_: Variant.Type) -> void:
	_value_or_null = Union.new(value_, [_permitted_type, Variant.Type.TYPE_NIL])
	_permitted_type = permitted_type_

func get_value() -> Variant:
	match typeof(_value_or_null):
		Variant.Type.TYPE_NIL:
			return null
		_permitted_type:
			return _value_or_null.get_value()
		_:
			push_error("Illegal state; value of Node[%s] has value %s of unpermitted type %s" % [_permitted_type, _value_or_null, typeof(_value_or_null)])
			return null
			
func set_value(value: Variant) -> void:
		if not _value_or_null.permits_assignment_of_type(typeof(value)):
			push_error("Illegal assignment of type %s to Nullable[%s]" % [typeof(value), _permitted_type])
			return
			
		_value_or_null = value
	
func is_null() -> bool:
	return typeof(_value_or_null) == Variant.Type.TYPE_NIL
