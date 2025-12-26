class_name PassiveInstance
extends RefCounted

var definition: PassiveDefinition
var level: int = 1

func _init(def: PassiveDefinition):
	definition = def
