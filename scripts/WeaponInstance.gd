class_name WeaponInstance
extends RefCounted

var definition: WeaponDefinition
var level: int = 1
var shot_timer: float = 0.0

func _init(def: WeaponDefinition):
	definition = def
