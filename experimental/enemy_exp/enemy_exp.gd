extends CharacterBody2D

@onready var _health : HealthComponent = %HealthComponent

var _inside : bool = false


func _ready():
	mouse_entered.connect(func(): _inside = true)
	mouse_exited.connect(func(): _inside = false)

	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left_action") and  _inside:
		_health.damage(1)
		print(get_instance_id(), ": ", _health.get_health())
