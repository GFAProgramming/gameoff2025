class_name HealthComponent
extends Node

@onready var _health: ResourceComponent = %Health

signal on_heal(initial_health: float, amount: float)
signal on_damage(initial_health: float, amount: float)
signal on_death

var _is_alive: bool

func _init(is_alive_: bool = true) -> void:
	_is_alive = is_alive_

func is_alive() -> bool:
	return _is_alive

func get_health() -> float:
	return _health.value
	
	
func heal(amount: float) -> float:
	if not _is_alive or amount <= 0.0:
		return _health.value
	
	on_heal.emit(_health.value, amount)
	_health.value += amount

	return _health.value

	
func damage(amount: float) -> float:
	if not _is_alive or amount <= 0.0:
		return _health.value

	on_damage.emit(_health.value, amount)
	_health.value -= amount
		
	if _health.value <= _health.min_value:
		_is_alive = false
		on_death.emit()
	
	return _health.value

	
func get_max_health() -> float:
	return _health.max_value

	
func get_min_health() -> float:
	return _health.min_value
	
	
## Sets the Max Health. Ensures that the max value is greater than or equal to min value.
func set_max_health(value: float):
	_health.max_value = max(_health.min_value, value)

## Sets the Min Health. Ensures that the min value is less than or equal to max.
func set_min_health(value: float):
	_health.min_value = min(_health.max, value)
	

func set_min_max_health(new_min: float, new_max: float):
	if new_min <= new_max:
		_health.min_value = new_min
		_health.max_value = new_max
	
