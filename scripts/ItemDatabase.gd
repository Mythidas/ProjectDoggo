extends Resource
class_name ItemDatabase

@export var items: Array[ItemDefinition]

func get_item(id: String):
	for item in items:
		if item.id == id:
			return item
	return null
