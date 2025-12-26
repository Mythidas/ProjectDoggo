extends Area2D

@onready var collision = $CollisionShape2D
@onready var sprite = $Sprite2D

var _stats: WeaponStats
var _hits: Array[Node2D]
var _velocity: Vector2 = Vector2.ZERO
var _level: int

func _process(_delta: float) -> void:
	if _stats == null:
		queue_free()

func shoot(stats: WeaponStats, level: int):
	_stats = stats
	_level = level
	body_entered.connect(_on_body_entered)
	
	position = GameMode.player.global_position
	collision.shape.radius = _stats.radius
	sprite.scale = Vector2(_stats.radius / 100.0, _stats.radius / 100.0)
	
	_velocity = Vector2.UP * stats.speed
	
	await get_tree().create_timer(stats.duration).timeout
	queue_free()
	
func _physics_process(_delta: float) -> void:
	position += _velocity

func _on_body_entered(body: Node2D):
	if GameMode.enemies.has(body):
		_hits.append(body)
		body.damage(_stats.damage)
		
		if _hits.size() >= _level + (_level - 1):
			queue_free()
