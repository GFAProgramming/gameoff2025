class_name UnitTest
extends GdUnitTestSuite

@warning_ignore_start("unused_parameter")

const __source: String = 'res://src/scene/unit/unit.gd'



#func test_is_unit(variant: Variant, is_unit: bool, test_parameters := [
	#[auto_free(Unit.new()), true],
	#[auto_free(Node.new()), false],
	#[auto_free(Tower.new()), false],
	#[null, false]
#]) -> void:
	#assert_bool(Unit.is_unit(variant)).is_equal(is_unit)
#
#func test_is_hostile_unit_with_hostility_values(hostility: Unit.Hostility, is_hostile_unit: bool, test_parameters := [
	#[Unit.Hostility.Hostile, true],
	#[Unit.Hostility.Friendly, false],
	#[Unit.Hostility.Neutral, false]
#]) -> void:
	#var unit = auto_free(Unit.new())
	#unit.hostility = hostility
#
	#assert_bool(Unit.is_hostile_unit(unit)).is_equal(is_hostile_unit)
#
#func test_is_hostile_unit_with_non_units(node: Variant, test_parameters := [
	#[null],
	#[auto_free(Node.new())]
#]) -> void:
	#assert_bool(Unit.is_hostile_unit(node)).is_false()
#
#func test_is_friendly_unit_with_hostility_values(hostility: Unit.Hostility, is_friendly_unit: bool, test_parameters := [
	#[Unit.Hostility.Hostile, false],
	#[Unit.Hostility.Friendly, true],
	#[Unit.Hostility.Neutral, false]
#]) -> void:
	#var unit = auto_free(Unit.new())
	#unit.hostility = hostility
#
	#assert_bool(Unit.is_friendly_unit(unit)).is_equal(is_friendly_unit)
#
#func test_is_friendly_unit_with_non_units(node: Variant, test_parameters := [
	#[null],
	#[auto_free(Node.new())]
#]) -> void:
	#assert_bool(Unit.is_friendly_unit(node)).is_false()
