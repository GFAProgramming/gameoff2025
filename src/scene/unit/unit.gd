## A `Unit` is a base class for non-player characters with movement (free or pre-determined)
class_name Unit
extends Node2D

enum Hostility {
	Friendly,
	Hostile,
	Neutral
}

@export_category("Unit Parameters")
@export var hostility: Hostility

@onready var health: HealthComponent = %HealthComponent
@onready var movement: MovementComponent = %MovementComponent
@onready var sprite2D: Sprite2D = %Sprite2D

func _init(hostility_: Hostility):
	hostility = hostility_

static func cast_to_nullable_unit(node: Node) -> Variant:
	return node as Unit

static func is_friendly_unit(unit: Unit) -> bool:
	return unit.hostility == Unit.Hostility.Friendly

static func is_hostile_unit(unit: Unit) -> bool:
	return unit.hostility == Unit.Hostility.Hostile
