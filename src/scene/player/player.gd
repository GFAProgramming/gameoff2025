extends CharacterBody2D

signal on_damage(amount: int, damage_type: DamageType, source: Node)


@export var movement_speed: float = 500.0
var _movement_direction : Vector2 = Vector2.ZERO


func _process(_delta: float):
	look_at(get_global_mouse_position())
	
	_movement_direction.x = Input.get_axis("move_left", "move_right")
	_movement_direction.y = Input.get_axis("move_up", "move_down")
	
	_movement_direction = _movement_direction.normalized()

	if _movement_direction:
		velocity = _movement_direction * movement_speed
		if %Sprite.animation != "Walking": %Sprite.animation = "Walking"
	else:
		velocity = velocity.move_toward(Vector2.ZERO, movement_speed)
		if %Sprite.animation != "Idle": %Sprite.animation = "Idle"

	move_and_slide()
	
	
func Damage(amount: int, damage_type: DamageType, source: Node):
	on_damage.emit(amount, damage_type, source)