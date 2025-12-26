extends Node2D

var weapons: Array[WeaponInstance] = []
var passives: Array[PassiveInstance] = []

func _ready() -> void:
	GameMode.player_item_chosen.connect(_on_player_item_chosen)

func _process(delta: float) -> void:
	_handle_weapons(delta)

func add_passive(item: PassiveDefinition):
	for passive in passives:
		if passive.definition.id == item.id:
			passive.level += 1
			return
	passives.append(PassiveInstance.new(item))

func add_weapon(item: WeaponDefinition):
	for weapon in weapons:
		if weapon.definition.id == item.id:
			weapon.level += 1
			_shoot_weapon(weapon)
			return
	weapons.append(WeaponInstance.new(item))

func _handle_weapons(delta: float):
	for w in weapons:
		w.shot_timer -= delta
		if w.shot_timer <= 0.0:
			_shoot_weapon(w)

func _shoot_weapon(w: WeaponInstance):
	var stats = w.definition.levels[min(w.definition.levels.size() - 1, w.level - 1)]
	if stats == null: return
	
	if stats.fire_rate != -1:
		w.shot_timer = 1 / stats.fire_rate
	else: w.shot_timer = INF
	
	var proj = w.definition.projectile.instantiate()
	get_tree().root.add_child(proj)
	
	proj.shoot(stats, min(w.level, 4))

func _on_player_item_chosen(id: String):
	var item = GameMode.item_database.get_item(id)
	if item:
		if item.item_type == ItemDefinition.ItemType.WEAPON: 
			add_weapon(item)
		if item.item_type == ItemDefinition.ItemType.PASSIVE:
			add_passive(item)
