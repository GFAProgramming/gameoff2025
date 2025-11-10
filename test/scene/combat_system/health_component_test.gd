# GdUnit generated TestSuite
class_name HealthTest
extends GdUnitTestSuite
@warning_ignore_start('unused_parameter')
@warning_ignore_start('redundant_await')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source: String = 'res://src/scene/combat_system/health_component.gd'

var health_component: HealthComponent

func before():
	health_component = monitor_signals(HealthComponent.new())
	health_component._health = auto_free(ResourceComponent.new())
	
## HealthComponent::heal() should:
##	- Incease health by ceiling(maximum health, current health + healing) if the amount of healing is positive
##  - Do nothing if the amount of healing is non-positive
func test_healing_with_amounts(initial_health: float, healing: float, expected_health: float, test_parameters := [
	[50.0, -1.0, 50.0],
	[50.0, 0.0, 50.0],
	[50.0, 1.0, 51.0]
]):
	health_component._health.value = initial_health
	var actual_health: float = health_component.heal(healing)
	assert_float(actual_health).is_equal(expected_health)


## HealthComponent::damage() should:
##	- Decrease health by floor(mininum health, current health - damage) if the amount of damage is positive
##  - Do nothing if the amount of damage is non-positive
func test_damage_with_amounts(initial_health: float, damage: float, expected_health: float, test_parameters := [
	[100.0, -1.0, 100.0],
	[100.0, 0.0, 100.0],
	[100.0, 1.0, 99.0]
]):
	health_component._health.value = initial_health
	var actual_health: float = health_component.damage(damage)
	assert_float(actual_health).is_equal(expected_health)
