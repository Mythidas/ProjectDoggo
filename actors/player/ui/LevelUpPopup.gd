extends Control

var _choices: Array[Button] = []
var _items: Array[ItemDefinition] = []

func _ready() -> void:
	_choices = [$ColorRect/Choice1, $ColorRect/Choice2, $ColorRect/Choice3]
	_choices[0].pressed.connect(_on_choice_selected.bind(0))
	_choices[1].pressed.connect(_on_choice_selected.bind(1))
	_choices[2].pressed.connect(_on_choice_selected.bind(2))
	
	GameMode.player_level_up.connect(_on_player_level_up)

func _on_choice_selected(_choice_id: int) -> void:
	GameMode.set_game_state(GameMode.GameState.GAME)
	if _choice_id <= _items.size() - 1:
		GameMode.player_item_chosen.emit(_items[_choice_id].id)
	else:
		GameMode.player_item_chosen.emit("")

func _on_player_level_up(level: int):
	GameMode.set_game_state(GameMode.GameState.MENU)
	
	var items: Array[ItemDefinition] = []
	var available: Dictionary[String, ItemDefinition] = {}
	
	var full_weapons = GameMode.player.weapon_manager.weapons.size() == 3
	for item in GameMode.player.weapon_manager.weapons:
		if item.level < 4:
			available[item.definition.id] = item.definition
	
	if !full_weapons:
		for item in GameMode.item_database.items:
			if item.item_type == ItemDefinition.ItemType.WEAPON and !available.has(item.id):
				available[item.id] = item

	var full_passives = GameMode.player.weapon_manager.passives.size() == 3
	for item in GameMode.player.weapon_manager.passives:
		if item.level < 4:
			available[item.definition.id] = item.definition
	
	if !full_passives and level != 2:
		for item in GameMode.item_database.items:
			if item.item_type == ItemDefinition.ItemType.PASSIVE and !available.has(item.id):
				available[item.id] = item
	
	var pool: Array[ItemDefinition] = []
	for key in available:
		pool.append(available[key])
	
	while items.size() < 3 and pool.size() > 0:
		var item = _weighted_pick(pool)
		
		items.append(item)
		pool.erase(item)
	
	_items = items.duplicate()
	for i in range(3):
		if i > items.size() - 1:
			_add_ui(_choices[i], null)
		else: _add_ui(_choices[i], items[i])

func _get_weapon_instance(id: String) -> WeaponInstance:
	for w in GameMode.player.weapon_manager.weapons:
		if w.definition.id == id:
			return w
	return null
	
func _get_passive_instance(id: String) -> PassiveInstance:
	for w in GameMode.player.weapon_manager.passives:
		if w.definition.id == id:
			return w
	return null

func _weighted_pick(pool: Array[ItemDefinition]) -> ItemDefinition:
	var total_weight = 0.0
	for item in pool:
		total_weight += item.rarity
		
	var r = randf() * total_weight
	for item in pool:
		r -= item.rarity
		if r <= 0:
			return item
			
	return pool.back()

func _add_ui(choice: Button, item: ItemDefinition):
	if item:
		choice.get_node("Icon").texture = item.icon
		choice.get_node("Name").text = item.display_name
		choice.get_node("Description").text = item.description
	else:
		choice.get_node("Name").text = "Spare Treats"
		choice.get_node("Description").text = "Its healing!"
