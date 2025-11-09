class_name TowerTest
extends GdUnitTestSuite

@warning_ignore_start("unused_parameter")

const __source: String = 'res://src/scene/tower/tower.gd'

var tower_spy: Tower
var neighboring_tower: Tower
var friendly_unit: Unit
var neutral_unit: Unit
var hostile_unit: Unit

func process_units_noop(units: Array[Unit], delta: float):
	return null

func before() -> void:
	tower_spy = spy(auto_free(Tower.new(null, null)))
	neighboring_tower = auto_free(Tower.new(null, null))
	friendly_unit = auto_free(Unit.new(Unit.Hostility.Friendly))
	neutral_unit = auto_free(Unit.new(Unit.Hostility.Neutral))
	hostile_unit = auto_free(Unit.new(Unit.Hostility.Hostile))

## _get_overlapping_units() should return a list of non-null, overlapping Unit objects
func test__get_overlapping_units(overlapping_areas: Array[Area2D], expected_overlapping_units: Array[Unit], test_parameters := [
	[[], []],
	[[null], []],
	[[friendly_unit], [friendly_unit]],
	[[friendly_unit, hostile_unit], [friendly_unit, hostile_unit]],
	[[neighboring_tower, friendly_unit, null, neutral_unit, neighboring_tower, hostile_unit], [friendly_unit, neutral_unit, hostile_unit]]
]) -> void:
	var tower: Tower = auto_free(Tower.new(null, null))
	var mock_area2D: Area2D = mock(Area2D)
	tower.area2D = mock_area2D
	
	do_return(overlapping_areas).on(mock_area2D).get_overlapping_areas()
	
	var actual_overlapping_units = tower._get_overlapping_units()
	
	assert_array(actual_overlapping_units).is_equal(expected_overlapping_units)

## _process_overlapping_units() should do nothing if both process_friendly_units 
## and process_hostile_units are null
func test__process_overlapping_units_should_do_nothing_if_both_processor_callables_are_null():
	tower_spy._process_overlapping_units(0.0)
	
	verify(tower_spy, 0)._get_overlapping_units()
