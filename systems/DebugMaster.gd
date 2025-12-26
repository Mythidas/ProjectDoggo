extends Node2D

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("skill_3"):
		GameMode.player.stat_manager.grant_xp(10000.0)
