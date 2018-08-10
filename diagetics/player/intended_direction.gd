extends Node

var intended_direction = Vector2()

func update_inputs():
	intended_direction = Vector2()
	if Input.is_action_pressed("ui_left"):
		intended_direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		intended_direction.x += 1
	if Input.is_action_pressed("ui_down"):
		intended_direction.y += 1
	if Input.is_action_pressed("ui_up"):
		intended_direction.y -= 1

func get_intended_direction():
	update_inputs()
	return intended_direction

