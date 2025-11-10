class_name HealthComponent
extends Node

@onready var _health: ResourceComponent = %Health

signal on_heal(initial_health: float, amount: float)
signal on_damage(initial_health: float, amount: float)
signal on_death

func get_health() -> float:
	return _health.value
	
func heal(amount: float) -> float:
	if amount > 0.0:
		on_heal.emit(_health.value, amount)
		_health.value += amount

	return _health.value

func damage(amount: float) -> float:
	if amount > 0.0:
		on_damage.emit(_health.value, amount)
		_health.value -= amount
		
	if _health.value <= 0.0:
		on_death.emit()
	
	return _health.value
