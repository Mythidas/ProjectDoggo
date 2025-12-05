extends Node2D

@export var health = 100.0
@export var experience: PackedScene

func _ready() -> void:
	GameMode.register_enemy(self)

func _process(_delta: float) -> void:
	pass

func damage(amt: float) -> void:
	health -= amt
	if health <= 0.0:
		kill()

func kill() -> void:
	var e = experience.instantiate()
	e.position = position
	get_parent().add_child(e)
	GameMode.deregister_enemy(self)
	queue_free()
