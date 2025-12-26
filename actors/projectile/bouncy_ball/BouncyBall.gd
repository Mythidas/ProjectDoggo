extends Area2D

@onready var collision = $CollisionShape2D
@onready var sprite = $Sprite2D

var _stats: WeaponStats
var _hits: Array[Node2D] = []
var _level: int
var _velocity = Vector2.ZERO

func _process(_delta: float) -> void:
	if _stats == null:
		queue_free()

func shoot(stats: WeaponStats, level: int):
	_stats = stats
	_level = level

	var enemy = GameMode.get_nearest_visible_enemy(global_position)
	if enemy == null:
		_velocity = (Vector2.UP - GameMode.player.global_position).normalized() * stats.speed
	else:
		_velocity = (enemy.global_position - GameMode.player.global_position).normalized() * stats.speed
	
	position = GameMode.player.global_position
	collision.shape.radius = _stats.radius
	sprite.scale = Vector2(_stats.radius / 100.0, _stats.radius / 100.0)
	body_entered.connect(_on_body_entered)
	
	await get_tree().create_timer(stats.duration).timeout
	queue_free()

func _physics_process(_delta: float) -> void:
	position += _velocity
	
func _on_body_entered(body: Node2D):
	if GameMode.enemies.has(body):
		body.damage(_stats.damage)
		_hits.append(body)
		
		var target = GameMode.get_nearest_visible_enemy(position, [body])
		if target:
			_velocity = Vector2(randf(), randf()).normalized() * _stats.speed
		
		if _hits.size() >= _level + 1:
			queue_free()
