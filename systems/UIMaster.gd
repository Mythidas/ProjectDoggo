extends Node

var level_up_popup: CanvasLayer

func _ready() -> void:
	level_up_popup = preload("res://scenes/LevelUp.tscn").instantiate()
	level_up_popup.hide()
	add_child(level_up_popup)

func show_level_up_popup():
	get_tree().paused = true
	level_up_popup.show()

func hide_level_up_popup():
	get_tree().paused = false
	level_up_popup.hide()
