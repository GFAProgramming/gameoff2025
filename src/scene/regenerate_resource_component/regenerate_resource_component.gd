class_name RegenerateResourceComponent
extends ResourceComponent

signal on_regenerating(value: bool)

@export_category("Regeneration Settings")
@export var regen_amount: float = 0

## How often the regeneration happens in seconds.
@export var regen_speed: float = 1.0

## Determines if the value is regenerating.
@export var is_regenerating: bool = true : set = _set_is_regenerating

@onready var timer : Timer = $regen_timer

func _ready() -> void:
	timer.wait_time = regen_speed
	timer.timeout.connect(_regenerate)
	
	if is_regenerating: 
		timer.start()
		

func _set_is_regenerating(v: bool):
	is_regenerating = v
	on_regenerating.emit(is_regenerating)
	
	if is_regenerating:
		timer.start()
	else:
		timer.stop()
		
	
## This function does not require delta time (I believe) as delta time is already considered by the Timer
func _regenerate():
	value += regen_amount
	