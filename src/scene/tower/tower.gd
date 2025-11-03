class_name Tower
extends Node2D
	
func _get_overlapping_hostile_units() -> Array[Unit]:
	return $Area2D.get_overlapping_areas()	\
				.filter(func(area2D): Unit.is_hostile_unit(area2D.owner))

func _process(delta: float) -> void:
	var hostile_units = _get_overlapping_hostile_units()
