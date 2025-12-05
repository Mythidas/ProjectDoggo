extends Area2D

@export var speed := 2.0
@export var lifetime := 5.0

var velocity = Vector2(0,0)
var timer = 0.0

func _process(delta: float) -> void:
	timer += delta
	if timer >= lifetime:
		queue_free()
		
	var enemies = get_overlapping_areas()
	for e in enemies:
		if !GameMode.enemies.has(e): continue
		e.damage(99.0)
		queue_free()

func _physics_process(_delta: float) -> void:
	position += velocity * speed 
	
func shoot(v: Vector2) -> void:
	velocity = v
