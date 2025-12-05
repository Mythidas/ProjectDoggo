extends Node2D

# Core
@export var level: int = 1
@export var xp: int = 0
@export var health: float = 100.0

# Passives
@export var pickup_radius: float = 30.0

func grant_xp(v: int) -> void:
	xp += v
	var target = (level * 50)
	if xp >= target:
		xp = xp - target
		UiMaster.show_level_up_popup()
