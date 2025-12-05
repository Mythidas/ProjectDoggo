extends Node

var player: Node2D = null
var enemies := []

func set_player(p):
	player = p

func register_enemy(e):
	enemies.append(e)

func deregister_enemy(e):
	enemies.erase(e)

func get_nearest_enemy(pos: Vector2):
	var nearest = null
	var nearest_dist = INF
	for e in enemies:
		var d = pos.distance_to(e.global_position)
		if d < nearest_dist:
			nearest = e
			nearest_dist = d
	return nearest
