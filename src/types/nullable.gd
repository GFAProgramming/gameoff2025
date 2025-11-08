class_name Nullable
extends Node

var __value: Union
var __permitted_type: Variant.Type

func _init(value_: Variant, permitted_type_: Variant.Type) -> void:
	__permitted_type = permitted_type_
	__value = Union.new(value_, [permitted_type_, Variant.Type.TYPE_NIL])

func get_value() -> Variant:
	return __value.get_value()
			
func set_value(value: Variant) -> void:
	__value.set_value(value)
	
func is_null() -> bool:
	return typeof(__value.get_value()) == Variant.Type.TYPE_NIL
