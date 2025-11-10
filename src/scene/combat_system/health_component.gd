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
	if _is_alive && amount > 0.0:
		on_heal.emit(_health.value, amount)
		_health.value += amount

	return _health.value

func damage(amount: float) -> float:
	if _is_alive && amount > 0.0:
		on_damage.emit(_health.value, amount)
		_health.value -= amount
		
	if _health.value <= 0.0:
		_is_alive = false
		on_death.emit()
	
	return _health.value
