extends RigidBody2D

@export var health = 100.0
@export var experience: PackedScene
@export var speed = 100.0

func _ready() -> void:
	GameMode.register_enemy(self)
	visibility_layer = 2

func _physics_process(_delta: float) -> void:
	linear_velocity = (GameMode.player.position - position).normalized() * speed

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
