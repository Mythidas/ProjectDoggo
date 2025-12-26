extends Area2D

@onready var collision = $CollisionShape2D

var _hit_enemies: Array[Node2D] = []
var _stats: WeaponStats

func _process(_delta: float) -> void:
	position = GameMode.player.global_position
	if _stats == null:
		queue_free()

func shoot(stats: WeaponStats, _level: int):
	_stats = stats
	collision.shape.radius = stats.radius
	body_entered.connect(_on_body_entered)
	position = GameMode.player.global_position
	
	queue_redraw()
	await get_tree().create_timer(stats.duration).timeout
	queue_free()
	
func _on_body_entered(body: Node2D):
	if body in _hit_enemies:
		return
	
	_hit_enemies.append(body)
	if GameMode.enemies.has(body):
		_hit_enemies.append(body)
		_hit_enemy(body)
		
func _hit_enemy(enemy: Node2D):
	if _stats: enemy.damage(_stats.damage)

func _draw():
	if _stats: draw_circle(Vector2.ZERO, _stats.radius, Color(0.2, 0.4, 1.0, 0.6))
