class_name RegenerateResourceComponent
extends ResourceComponent

signal on_regenerating(value: bool)

@export_category("Regeneration Settings")
@export var regen_amount: float = 0

## How often the regeneration happens in seconds.
@export var regen_speed: float = 1.0

## Determines if the value is regenerating.
@export var is_regenerating: bool = true : set = _set_is_regenerating

var timer : SceneTreeTimer

func _ready() -> void:
	timer = get_tree().create_timer(regen_speed)
	
	if is_regenerating: 
		_regenerate(get_process_delta_time())


func _set_is_regenerating(v: bool):
	is_regenerating = v
	on_regenerating.emit(is_regenerating)
	
	if is_regenerating:
		timer.start()
	else:
		timer.stop()
	
	
func _regenerate(delta: float):
	value += (regen_amount * delta)
	
	await timer.timeout
	

