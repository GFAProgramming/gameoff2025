class_name ResourceComponent
extends Node

signal on_value_changed(old_value: float, new_value: float)


@export_category("Value Control Settings")
@export var min_value: float = 0
@export var max_value: float = 100

# Default value is max_value
@export var value: float = max_value: 
	set = _set_value, get = _get_value


func _set_value(new_value: float) -> void:
	var old_value : float = value
	value = clamp(new_value, min_value, max_value)
	
	if old_value != value:
		on_value_changed.emit(old_value, value)

	
func _get_value() -> float:
	return value

