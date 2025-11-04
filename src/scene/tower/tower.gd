class_name Tower
extends Node2D

## A method that will be called every from on friendly units
@export var process_friendly_units: Union # [Callable | null]

## A method that will be called every frame on hostile units
@export var process_hostile_units: Union # [Callable | null]

func _init(process_friendly_units_: Variant, process_hostile_units_: Variant):
	process_friendly_units = Union.new(process_friendly_units_, [Variant.Type.TYPE_NIL, Variant.Type.TYPE_CALLABLE])
	process_hostile_units = Union.new(process_hostile_units_, [Variant.Type.TYPE_NIL, Variant.Type.TYPE_CALLABLE])
	
func _process(delta: float) -> void:
	_process_overlapping_units(delta)
	
func _process_overlapping_units(delta: float) -> void:
	if not process_friendly_units && not process_hostile_units:
		return
	
	var overlapping_units: Array[Unit] = _get_overlapping_units()
	
	if not process_friendly_units.is_null():
		var friendly_units: Array[Unit] = overlapping_units.filter(Unit.is_friendly_unit)
		process_friendly_units.value.call(friendly_units, delta)
		
	if not process_hostile_units.is_null():
		var hostile_units: Array[Unit] = overlapping_units.filter(Unit.is_hostile_unit)
		process_hostile_units.value.call(hostile_units, delta)

func _get_overlapping_units() -> Array[Unit]:
	return $Area2D.get_overlapping_areas()													\
					.filter(func(area2D): return Unit.cast_to_nullable_unit(area2D.owner))	\
					.filter(func(unit_or_null): return unit_or_null != null)
				
