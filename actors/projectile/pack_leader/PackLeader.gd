extends Area2D

@onready var collision = $CollisionShape2D
@onready var sprite = $Sprite2D

var _stats: WeaponStats
var _level: int

func shoot(stats: WeaponStats, level: int):
	_stats = stats
	_level = level
	body_entered.connect(_on_body_entered)
	
func _process(_delta: float) -> void:
	var offset = Vector2(cos(GameMode.timer * _level), sin(GameMode.timer * _level)).normalized() * _stats.radius
	position = GameMode.player.global_position + offset
	visible = true
	if _stats == null:
		queue_free()

func _on_body_entered(body: Node2D):
	if GameMode.enemies.has(body):
		body.damage(_stats.damage)
