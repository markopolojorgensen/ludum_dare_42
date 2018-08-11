extends Node

var intended_direction = Vector2()
var overridden = false

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
	if not overridden:
		update_inputs()
	
	return intended_direction

func override(direction):
	# print("direction override!")
	overridden = true
	intended_direction = direction

func clear_override():
	overridden = false


