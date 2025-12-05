extends CanvasLayer

@onready var choice1 = $Control/ColorRect/Choice1
@onready var choice2 = $Control/ColorRect/Choice2
@onready var choice3 = $Control/ColorRect/Choice3

func _ready() -> void:
	# Connect signals safely (won't crash if node is missing)
	choice1.pressed.connect(_on_choice_selected.bind(1))
	choice2.pressed.connect(_on_choice_selected.bind(2))
	choice3.pressed.connect(_on_choice_selected.bind(3))

func _on_choice_selected(_choice_id: int) -> void:
	GameMode.player.weapon_manager.add_weapon(Weapons.ID.DEBUG)
	UiMaster.hide_level_up_popup()
