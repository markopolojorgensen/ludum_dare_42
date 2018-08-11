extends Node

signal dashing
signal done_dashing

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
		
		lzd.dash_begin()
		
		emit_signal("dashing")
		
		body.set_collision_mask_bit(0, false)
		body.set_collision_mask_bit(3, false)
		
		movement.max_speed *= 8
		movement.acceleration *= 8
		
		$dash_timer.start()
		yield($dash_timer, "timeout")
		
		dash_end()

func dash_end():
	if dashing:
		dashing = false
		
		movement.max_speed /= 8
		movement.acceleration /= 8
		
		lzd.dash_end()
		
		emit_signal("done_dashing")
		
		body.set_collision_mask_bit(0, true)
		body.set_collision_mask_bit(3, true)




