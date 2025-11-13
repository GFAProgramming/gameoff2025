extends Node2D


func _process(delta: float) -> void:
	if Input.is_action_pressed("left_action"):
		print(get_local_mouse_position())