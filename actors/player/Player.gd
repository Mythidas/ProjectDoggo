extends CharacterBody2D

@export var speed = 300.0
@export var spring = 0.25
@onready var weapon_manager = $WeaponManager
@onready var stat_manager = $StatManager

func _ready() -> void:
	GameMode.set_player(self)

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	_move_player()

func _move_player() -> void:
	var vertical := Input.get_axis("mv_up", "mv_down")
	var horizontal := Input.get_axis("mv_left", "mv_right")

	var input = Vector2(horizontal, vertical) * speed
	velocity = velocity.lerp(input, spring)

	move_and_slide()
