extends ItemDefinition
class_name PassiveDefinition

enum Stats {
	HEALTH,
	ARMOR,
	MOVE_SPEED,
	PICKUP_RADIUS,
	XP_GAIN
}

@export var stat: Stats
@export var levels: Array[float]
