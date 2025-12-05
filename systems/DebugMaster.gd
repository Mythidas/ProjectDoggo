extends Node2D

var weapon = Weapons.ID.DEBUG

func _process(_delta: float) -> void:
	_test_adding_weapon()
	pass

func _test_adding_weapon() -> void:
	if Input.is_action_just_pressed("ui_accept"):
		GameMode.player.weapon_manager.add_weapon(weapon)
