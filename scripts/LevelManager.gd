extends Node2D

@export var enemy_scene: PackedScene

var _timer = 0.0
var enemy_pool: Node2D

func _ready() -> void:
	enemy_pool = Node2D.new()
	enemy_pool.name = "EnemyPool"
	add_child(enemy_pool)

func _process(delta: float) -> void:
	_timer += delta
	_spawn_enemies()

func _spawn_enemies() -> void:
	if _timer >= 10.0 && enemy_pool.get_children().size() < 10:
		var enemy = enemy_scene.instantiate()
		enemy_pool.add_child(enemy)
