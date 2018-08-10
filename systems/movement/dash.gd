extends Node

export(NodePath) var body_path
onready var body = get_node(body_path)

export(NodePath) var movement_path
onready var movement = get_node(movement_path)

var dashing = false

func _unhandled_input(event):
	if event.is_action_pressed("dash") and not dashing:
		dashing = true
		print("dash")
		
		movement.max_speed *= 8
		movement.acceleration *= 8
		
		$dash_timer.start()
		yield($dash_timer, "timeout")
		
		movement.max_speed /= 8
		movement.acceleration /= 8
		dashing = false


