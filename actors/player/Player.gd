extends CharacterBody2D

@export var spring = 0.25

@onready var weapon_manager = $WeaponManager
@onready var stat_manager = $StatManager
@onready var skill_manager = $SkillManager
@onready var ui_manager = $UiManager

var last_dir = Vector2.ZERO

func _ready() -> void:
	GameMode.set_player(self)
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause_menu"):
		ui_manager.open_pause_menu()

func _physics_process(_delta: float) -> void:
	_move_player()
	
func dash() -> bool:
	var vertical := Input.get_axis("mv_up", "mv_down")
	var horizontal := Input.get_axis("mv_left", "mv_right")
	if Vector2(vertical, horizontal) != Vector2.ZERO:
		velocity *= stat_manager.dash_speed
		return true
	else:
		return false

func _move_player() -> void:
	var vertical := Input.get_axis("mv_up", "mv_down")
	var horizontal := Input.get_axis("mv_left", "mv_right")

	var input = Vector2(horizontal, vertical)
	velocity = velocity.lerp(input * stat_manager.speed, spring)
	
	if input != Vector2.ZERO:
		last_dir = input

	move_and_slide()
