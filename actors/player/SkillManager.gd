extends Node2D

var s1_cooldown = 2.0
var s2_cooldown = 2.0
var s3_cooldown = 2.0
var s4_cooldown = 2.0

var s1_timer = 0.0
var s2_timer = 0.0
var s3_timer = 0.0
var s4_timer = 0.0

func _process(delta: float) -> void:
	s1_timer -= delta
	s2_timer -= delta
	s3_timer -= delta
	s4_timer -= delta
	
	# Dash ability
	if Input.is_action_just_pressed("mv_dash") && s1_timer <= 0.0:
		if GameMode.player.dash():
			s1_timer = s1_cooldown
	
	if Input.is_action_just_pressed("skill_1") && s2_timer <= 0.0:
		s2_timer = s2_cooldown

	if Input.is_action_just_pressed("skill_2") && s3_timer <= 0.0:
		s3_timer = s3_cooldown
		
	if Input.is_action_just_pressed("skill_3") && s4_timer <= 0.0:
		s4_timer = s4_cooldown
