extends Node2D

@export var value = 10

@onready var player = GameMode.player

func _process(_delta: float) -> void:
	if player.position.distance_to(position) <= player.stat_manager.pickup_radius:
		player.stat_manager.grant_xp(value)
		queue_free()
