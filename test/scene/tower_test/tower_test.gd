class_name TowerTest
extends GdUnitTestSuite
@warning_ignore_start("unused_parameter")

const __source: String = 'res://src/scene/tower/tower.gd'

var tower: Tower
var neighboring_tower: Tower
var friendly_unit: Unit
var hostile_unit: Unit

func before() -> void:
	tower = auto_free(Tower.new(null, null))
	neighboring_tower = auto_free(Tower.new(null, null))
	
	friendly_unit = auto_free(Unit.new(Unit.Hostility.Friendly))
	
	hostile_unit = auto_free(Unit.new(Unit.Hostility.Hostile))

#func test__get_overlapping_units(overlapping_areas: Array[Area2D], expected_overlapping_units: Array[Unit], test_parameters := [
	#[[], []],
	#[[neighboring_tower], []],
	#[[friendly_unit], []],
	#[[friendly_unit, neighboring_tower, hostile_unit], [friendly_unit, hostile_unit]]
#]) -> void:
	#var actual_overlapping_units = tower._get_overlapping_units()
	#assert_vector(actual_overlapping_units).is_equal(expected_overlapping_units)
