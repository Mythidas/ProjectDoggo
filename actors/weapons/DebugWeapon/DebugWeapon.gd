extends Node2D

@export var cooldown = 2.0
@export var projectile: PackedScene

var timer := 0.0

func update_weapon(delta: float):
	timer -= delta
	if timer <= 0:
		fire()
		timer = cooldown
		
func fire():
	print("Debug Fire")
	var enemy = GameMode.get_nearest_enemy(GameMode.player.position)
	if enemy == null: return
	
	var p = projectile.instantiate()
	p.position = GameMode.player.position
	p.shoot((enemy.position - GameMode.player.position).normalized())
	
	GameMode.player.get_parent().add_child(p)
