extends Node2D

@export var enemy_scene: PackedScene

var enemy_pool: Node2D

var _spawn_cooldown = 0.0

func _ready() -> void:
	enemy_pool = Node2D.new()
	enemy_pool.name = "EnemyPool"
	add_child(enemy_pool)

func _process(delta: float) -> void:
	_spawn_cooldown -= delta
	
	_spawn_enemies()

func _spawn_enemies() -> void:
	if _spawn_cooldown <= 0 and enemy_pool.get_children().size() < 30:
		_spawn_cooldown = 1.0
		var half_screen = get_viewport().get_visible_rect().size * 0.5
		var enemy = enemy_scene.instantiate()
		
		var side = randi() % 4
		var spawn_margin = 10.0
		var center = GameMode.player.global_position
		match side:
			0:  # Left
				enemy.global_position = Vector2(
					center.x - half_screen.x - spawn_margin,
					center.y + randf_range(-half_screen.y, half_screen.y)
				)
			1:  # Right
				enemy.global_position = Vector2(
					center.x + half_screen.x + spawn_margin,
					center.y + randf_range(-half_screen.y, half_screen.y)
				)
			2:  # Top
				enemy.global_position = Vector2(
					center.x + randf_range(-half_screen.x, half_screen.x),
					center.y - half_screen.y - spawn_margin
				)
			3:  # Bottom
				enemy.global_position = Vector2(
					center.x + randf_range(-half_screen.x, half_screen.x),
					center.y + half_screen.y + spawn_margin
				)
		enemy_pool.add_child(enemy)
