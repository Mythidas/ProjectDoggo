extends Node

enum GameState {
	MENU,
	GAME
}

@onready var item_database: ItemDatabase = preload("res://resources/ItemDatabase.tres")

var player: CharacterBody2D = null
var enemies: Array[Node2D] = []
var timer = 0.0
var game_state: GameState = GameState.GAME

@warning_ignore("unused_signal")
signal player_level_up(level)
@warning_ignore("unused_signal")
signal player_item_chosen(id)

func _ready() -> void:
	set_game_state(GameState.GAME)

func _process(delta: float) -> void:
	timer += delta

func set_game_state(state: GameState):
	game_state = state
	
	if state == GameState.MENU:
		get_tree().paused = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		get_tree().paused = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func set_player(p: Node2D):
	player = p

func register_enemy(e: Node2D):
	enemies.append(e)

func deregister_enemy(e: Node2D):
	enemies.erase(e)

func get_nearest_visible_enemy(from_pos: Vector2, omit: Array[Node2D] = [], max_range: float = INF) -> Node2D:
	var nearest: Node2D = null
	var nearest_dist: float = INF
	
	for e in enemies:
		if omit.has(e):
			continue
		
		var enemy_pos: Vector2 = e.global_position
		var dist: float = from_pos.distance_to(enemy_pos)
		
		# Skip if out of range
		if dist > max_range or dist >= nearest_dist:
			continue
		
		# Check line-of-sight (ray from 'from_pos' to enemy)
		if is_visible(from_pos, e):
			nearest = e
			nearest_dist = dist
	
	return nearest

func is_visible(from_pos: Vector2, enemy: Node2D) -> bool:
	var enemy_pos = enemy.global_position

	var space_state = player.get_world_2d().direct_space_state

	var query = PhysicsRayQueryParameters2D.create(from_pos, enemy_pos)
	query.collide_with_areas = true
	query.collision_mask = 1 | 2 | 4  # adjust to your layers
	query.exclude = [player.get_rid()]  # exclude player correctly

	var result = space_state.intersect_ray(query)

	if result.is_empty():
		return true

	var collider = result["collider"]

	# Check if the hit object is part of the enemy
	if enemy == collider or enemy.is_ancestor_of(collider):
		return true

	return false
