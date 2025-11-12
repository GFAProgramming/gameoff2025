class_name Enemy
extends Unit

static var castle: Castle = null

func _ready() -> void:
	if castle == null:
		castle = get_tree().current_scene.find_child("Castle")

func _init() -> void:
	super(Unit.Hostility.Hostile)

func _process(delta: float) -> void:
	position.move_toward(castle.position, delta * movement.speed.value)
