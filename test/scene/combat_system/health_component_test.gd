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
	health_component = monitor_signals(HealthComponent.new(true))
	health_component._health = auto_free(ResourceComponent.new())

## HealthComponent::heal() should:
##	- Incease health by ceiling(maximum health, current health + healing) if the amount of healing is positive
##  - Do nothing if the amount of healing is non-positive
func test_heal_with_amounts(initial_health: float, healing: float, expected_health: float, test_parameters := [
	[50.0, -1.0, 50.0],
	[50.0, 0.0, 50.0],
	[50.0, 1.0, 51.0]
]):
	health_component._health.value = initial_health
	var actual_health: float = health_component.heal(healing)
	assert_float(actual_health).is_equal(expected_health)

## HealthComponent::heal() should do nothing if the entity is not alive
func test_heal_with_alive_values(initial_health: float, is_alive: bool, healing: float, expected_health: float, test_parameters := [
	[50.0, true, 10.0, 60.0],
	[50.0, false, 10.0, 50.0]
]) -> void:
	health_component._health.value = initial_health
	health_component._is_alive = is_alive
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

## HealthComponent::damage() should do nothing if the entity is not alive
func test_damage_with_alive_values(initial_health: float, is_alive: bool, damage: float, expected_health: float, test_parameters := [
	[50.0, true, 10.0, 40.0],
	[50.0, false, 10.0, 50.0]
]) -> void:
	health_component._health.value = initial_health
	health_component._is_alive = is_alive
	var actual_health: float = health_component.damage(damage)
	assert_float(actual_health).is_equal(expected_health)

## HealthComponent::damage() should update _is_alive iff health equals 0.0
func test_damage_sets_is_alive_on_death(initial_health: float, damage: float, expected_health: float, expected_is_alive: bool, test_parameters := [
	[50.0, 10.0, 40.0, true],
	[50.0, 50.0, 0.0, false],
	[50.0, 49.99, 0.01, true]
]) -> void:
	health_component._health.value = initial_health
	health_component._is_alive = true
	
	var actual_health: float = health_component.damage(damage)
	assert_float(actual_health).is_equal_approx(expected_health, 0.01)
	assert_bool(health_component._is_alive).is_equal(expected_is_alive)
