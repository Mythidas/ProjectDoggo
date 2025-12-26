extends Node2D

# Core
@export var level: int = 1
@export var xp: int = 0
@export var health: float = 100.0
@export var max_health: float = 100.0

# Passives
@export var speed: float = 300.0
@export var dash_speed: float = 5.0
@export var pickup_radius: float = 30.0

var _xp_needed: int = 50

func _ready() -> void:
	GameMode.player_item_chosen.connect(_on_player_item_chosen)

func grant_xp(v: int) -> void:
	xp += v
	
	if xp >= _xp_needed:
		level += 1
		_xp_needed += (level * 30)
		
		GameMode.player_level_up.emit(level)

func _on_player_item_chosen(id: String):
	if id == "": health = max_health
	
	await get_tree().create_timer(0.05).timeout
	grant_xp(0)
