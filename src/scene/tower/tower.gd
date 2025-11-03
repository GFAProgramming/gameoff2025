class_name Tower
extends Node2D

@export var detection_radius: float:
	get:
		return detection_radius
	set(value):
		validate_detection_radius(value)
		detection_radius = value

func validate_detection_radius(value: float) -> Error:
	if value < 0.0:
		push_error("Failed to set Tower::detection_radius because value %f is negative." % value)
		return Error.ERR_PARAMETER_RANGE_ERROR
			
	return Error.OK

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
