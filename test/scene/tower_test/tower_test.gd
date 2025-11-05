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

#func test__get_overlapping_units_with
