extends Resource
class_name ItemDefinition

@export var id: String
@export var evolve_item_link: String # The ID of the item this needs to evolve with
@export var display_name: String
@export var description: String
@export var icon: Texture2D
@export var rarity: int = 1

enum ItemType {
	WEAPON,
	PASSIVE
}

@export var item_type: ItemType
