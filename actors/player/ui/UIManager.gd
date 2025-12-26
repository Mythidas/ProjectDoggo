extends CanvasLayer

# Skills
@onready var s1_texture = $Skills/Skill1/Cooldown
@onready var s2_texture = $Skills/Skill2/Cooldown
@onready var s3_texture = $Skills/Skill3/Cooldown
@onready var s4_texture = $Skills/Skill4/Cooldown

@onready var items = [$Items/Item1, $Items/Item2, $Items/Item3]
@onready var passives = [$Passives/Item1, $Passives/Item2, $Passives/Item3]

# Misc
@onready var timer_label = $Timer
@onready var level_up_popup = $LevelUp
@onready var pause_menu = $PauseMenu



func _ready() -> void:
	level_up_popup.hide()
	
	GameMode.player_level_up.connect(_on_player_level_up)
	GameMode.player_item_chosen.connect(_on_player_item_chosen)
	
	$PauseMenu/ColorRect/Resume.pressed.connect(close_pause_menu)

func _process(_delta: float) -> void:
	var skill_manager = GameMode.player.skill_manager
	_handle_cooldown(s1_texture, skill_manager.s1_timer, skill_manager.s1_cooldown)
	_handle_cooldown(s2_texture, skill_manager.s2_timer, skill_manager.s2_cooldown)
	_handle_cooldown(s3_texture, skill_manager.s3_timer, skill_manager.s3_cooldown)
	_handle_cooldown(s4_texture, skill_manager.s4_timer, skill_manager.s4_cooldown)
	
	_update_timer()

func open_pause_menu():
	GameMode.set_game_state(GameMode.GameState.MENU)
	pause_menu.visible = true
	
func close_pause_menu():
	GameMode.set_game_state(GameMode.GameState.GAME)
	pause_menu.visible = false

func _on_player_level_up(_level: int):
	GameMode.set_game_state(GameMode.GameState.MENU)
	level_up_popup.show()

func _on_player_item_chosen(id):
	GameMode.set_game_state(GameMode.GameState.GAME)
	level_up_popup.hide()
	if id == "": return
	
	var item = GameMode.item_database.get_item(id)
	if item.item_type == ItemDefinition.ItemType.WEAPON:
		for i in range(GameMode.player.weapon_manager.weapons.size()):
			items[i].evaluate(GameMode.player.weapon_manager.weapons[i].definition, GameMode.player.weapon_manager.weapons[i].level)
	else:
		for i in range(GameMode.player.weapon_manager.passives.size()):
			passives[i].evaluate(GameMode.player.weapon_manager.passives[i].definition, GameMode.player.weapon_manager.passives[i].level)

func _handle_cooldown(tex: TextureRect, timer: float, cooldown: float):
	if timer >= -0.1:
		var progress = 1.0 - (timer / cooldown)
		tex.visible = true
		tex.material.set_shader_parameter("fill_amount", progress)
	else:
		tex.visible = false

func _update_timer():
	var seconds = int(fmod(GameMode.timer, 60.0))
	var minutes = int(floor(GameMode.timer / 60.0))
	
	var f_secs = str(seconds) if seconds >= 10 else "0" + str(seconds) 
	var f_mins = str(minutes) if minutes >= 10 else "0" + str(minutes)
	
	timer_label.text = f_mins + ":" + f_secs
