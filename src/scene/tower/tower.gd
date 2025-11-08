class_name Tower
extends Node2D

## A method that will be called every from on friendly units
@export var process_friendly_units: Nullable = Nullable.new(null, Variant.Type.TYPE_CALLABLE)

## A method that will be called every frame on hostile units
@export var process_hostile_units: Nullable = Nullable.new(null, Variant.Type.TYPE_CALLABLE)

@onready var area2D: Area2D = $Area2D

func _init(process_friendly_units_: Variant, process_hostile_units_: Variant):
	process_friendly_units.set_value(process_friendly_units_)
	process_hostile_units.set_value(process_hostile_units_)
	
func _process(delta: float) -> void:
	_process_overlapping_units(delta)
	
func _process_overlapping_units(delta: float) -> void:
	if process_friendly_units.is_null() and process_hostile_units.is_null():
		return
	
	var overlapping_units: Array[Unit] = _get_overlapping_units()
	
	if not process_friendly_units.is_null():
		var friendly_units: Array[Unit] = overlapping_units.filter(Unit.is_friendly_unit)
		process_friendly_units.value.call(friendly_units, delta)
		
	if not process_hostile_units.is_null():
		var hostile_units: Array[Unit] = overlapping_units.filter(Unit.is_hostile_unit)
		process_hostile_units.value.call(hostile_units, delta)

func _get_overlapping_units() -> Array[Unit]:
	return area2D.get_overlapping_areas()												\
				.filter(func(area2D): return Unit.cast_to_nullable_unit(area2D.owner))	\
				.filter(func(unit_or_null): return unit_or_null != null)
				
