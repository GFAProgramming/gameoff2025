@abstract class_name Unit
extends Node2D

enum Hostility {
	Friendly,
	Hostile,
	Neutral
}

@export var hostility: Hostility



static func is_hostile_unit(node: Node) -> bool:
	if node is not Unit:
		return false
	
	var unit = node as Unit
	return unit.hostility == Unit.Hostility.Hostile
	
