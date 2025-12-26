extends Control

@onready var icon = $Icon
@onready var level_pips = [$Level/Pip1, $Level/Pip2, $Level/Pip3, $Level/Pip4]

func evaluate(item: ItemDefinition, level: int):
	visible = true
	icon.texture = item.icon
	for i in range(level):
		level_pips[i].visible = true
