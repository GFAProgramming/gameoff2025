# A `Unit` is a base class for non-player characters with movement (free or pre-determined)
class_name Unit
extends Node2D

enum Hostility {
	Friendly,
	Hostile,
	Neutral
}

@export var hostility: Hostility

func _init(hostility: Hostility):
	self.hostility = hostility

static func cast_to_nullable_unit(node: Node) -> Variant:
	return node as Unit

static func is_friendly_unit(unit: Unit) -> bool:
	return unit.hostility == Unit.Hostility.Friendly

static func is_hostile_unit(unit: Unit) -> bool:
	return unit.hostility == Unit.Hostility.Hostile
