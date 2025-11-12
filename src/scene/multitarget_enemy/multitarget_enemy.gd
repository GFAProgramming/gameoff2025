extends Node


## The list of enemies whose health contributes to the total health.
@export var enemies : Array[Node2D]

@onready var _max_health : float = 0.0

@onready var _health : HealthComponent = %HealthComponent

func _ready():
	_max_health = _get_total_health()
	_health.heal(_health.get_max_health())

	for enemy in enemies:
		var hc : HealthComponent = enemy.get_node("res://scenes/combat_system/HealthComponent.tscn")
		if hc != null:
			hc.on_damage.connect(_health.damage.bind())
			


func _get_total_health() -> float:
	var total := 0.0
	
	for enemy in enemies:
		var hc : HealthComponent = enemy.get_node("res://scenes/combat_system/HealthComponent.tscn")
		if hc != null:
			total += hc.get_health()
		
	return total
			