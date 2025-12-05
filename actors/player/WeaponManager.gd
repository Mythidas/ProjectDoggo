extends Node2D

@export var database: WeaponDatabase
var weapons = []

func _process(delta: float) -> void:
	handle_weapons(delta)

func add_weapon(w: Weapons.ID):
	var instance = database.weapons[w].instantiate()
	weapons.append(instance)
	add_child(instance)
	
func handle_weapons(delta: float):
	for w in weapons:
		w.update_weapon(delta)
