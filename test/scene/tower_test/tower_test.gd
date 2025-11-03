class_name TowerTest
extends GdUnitTestSuite

@warning_ignore_start("unused_parameter")
@warning_ignore_start("redundant_await")

const __source: String = 'res://src/scene/tower/tower.gd'

var tower: Tower

func before_test() -> void:
	tower = auto_free(Tower.new())

## When Tower::detection_radius is set to a valid (non-null, non-negative) value, then no error should occur
func test_validate_detection_radius_with_value_values(valid_value: float, test_parameters := [
	[0.0], 
	[1.0], 
	[100.0]
]) -> void:
	assert_error(func(): 
		tower.detection_radius = valid_value
	).is_success()

## When Tower::detection_radius is set to a negative value, then an error should be pushed
func test_validate_detection_radius_with_negative_values(negative_value: float, test_parameters := [
	[-0.000001],
	[-1.0],
	[-100.0]
]) -> void:
	await assert_error(func():
		tower.detection_radius = negative_value
	).is_push_error("Failed to set Tower::detection_radius because value %f is negative." % negative_value)
