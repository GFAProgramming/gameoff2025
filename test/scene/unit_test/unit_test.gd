class_name UnitTest
extends GdUnitTestSuite

@warning_ignore_start("unused_parameter")

const __source: String = 'res://src/scene/unit/unit.gd'

## cast_to_nullable_unit() should return a Unit if the variant is Unit or subclass of Unit;
## otherwise, it should return null
func test_cast_to_nullable_unit(variant: Variant, is_instance_of_unit: bool, test_parameters := [
	[auto_free(Unit.new(Unit.Hostility.Friendly)), true],
	[auto_free(Node.new()), false],
	[auto_free(Tower.new(null, null)), false],
	[null, false]
]) -> void:
	assert_bool(Unit.cast_to_nullable_unit(variant) != null).is_equal(is_instance_of_unit)

## is_hostile_unit() should return true if and only if the Unit is Unity.Hostility.Hostile
func test_is_hostile_unit(hostility: Unit.Hostility, is_hostile_unit: bool, test_parameters := [
	[Unit.Hostility.Hostile, true],
	[Unit.Hostility.Friendly, false],
	[Unit.Hostility.Neutral, false]
]) -> void:
	var unit = auto_free(Unit.new(hostility))

	assert_bool(Unit.is_hostile_unit(unit)).is_equal(is_hostile_unit)

## is_friendly_unit() should return true if and only if the unit is Unit.Hostility.Friendly
func test_is_friendly_unit(hostility: Unit.Hostility, is_friendly_unit: bool, test_parameters := [
	[Unit.Hostility.Hostile, false],
	[Unit.Hostility.Friendly, true],
	[Unit.Hostility.Neutral, false]
]) -> void:
	var unit = auto_free(Unit.new(hostility))

	assert_bool(Unit.is_friendly_unit(unit)).is_equal(is_friendly_unit)
