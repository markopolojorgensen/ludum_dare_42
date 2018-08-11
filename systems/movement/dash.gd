extends Node

export(NodePath) var body_path
onready var body = get_node(body_path)

export(NodePath) var movement_path
onready var movement = get_node(movement_path)

export(NodePath) var landing_zone_detector_path
onready var lzd = get_node(landing_zone_detector_path)

var dashing = false

func _unhandled_input(event):
	if event.is_action_pressed("dash") and not dashing:
		dashing = true
		print("dash")
		
		lzd.dash_begin()
		
		body.set_collision_mask_bit(0, false)
		
		movement.max_speed *= 8
		movement.acceleration *= 8
		
		$dash_timer.start()
		yield($dash_timer, "timeout")
		
		movement.max_speed /= 8
		movement.acceleration /= 8
		
		dashing = false
		
		lzd.dash_end()
		
		body.set_collision_mask_bit(0, true)


