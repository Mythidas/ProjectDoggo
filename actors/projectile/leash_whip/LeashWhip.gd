extends Area2D

@onready var collision = $CollisionShape2D
@onready var sprite = $Sprite2D

var _stats: WeaponStats
var _hits: Array[Node2D]
var _level: int
var _offset: Vector2 = Vector2.ZERO

func shoot(stats: WeaponStats, level: int):
	_stats = stats
	_level = level
	body_entered.connect(_on_body_entered)
	
	collision.shape.radius = _stats.radius
	sprite.scale = Vector2(_stats.radius / 100.0, _stats.radius / 100.0)
	
	var pos = 1
	while pos <= _level:
		_update_position(pos)
		await get_tree().create_timer(stats.duration).timeout
		pos += 1
		
	queue_free()
	
func _process(_delta: float) -> void:
	if _stats == null:
		queue_free()
	position = GameMode.player.global_position + _offset
	
func _update_position(pos: int):
	var increment = 30.0
	if pos == 1:
		_offset = Vector2.ZERO
		_offset.y -= increment
	if pos == 2:
		_offset = Vector2.ZERO
		_offset.y += increment
	if pos == 3:
		_offset = Vector2.ZERO
		_offset.x -= increment
	if pos == 4:
		_offset = Vector2.ZERO
		_offset.x += increment

func _on_body_entered(body: Node2D):
	if GameMode.enemies.has(body):
		_hits.append(body)
		body.damage(_stats.damage)
