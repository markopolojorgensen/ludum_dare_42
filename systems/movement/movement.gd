extends Node

export(NodePath) var body_path
onready var body = get_node(body_path)

export(int) var acceleration = 3000
export(int) var max_speed = 500

export(NodePath) var intended_direction_path
onready var intended_direction = get_node(intended_direction_path)

var stop_moving = false
var frozen = false

func do_movement(state):
	var id = intended_direction.get_intended_direction()
	if id.length() > 0.1 and not frozen:
		# accelerate that direction
		body.apply_impulse(Vector2(), id.normalized() * acceleration * state.step)
	
	# enforce max speed
	if state.linear_velocity.length() > max_speed:
		state.linear_velocity = state.linear_velocity.normalized() * max_speed
	
	if stop_moving:
		state.linear_velocity = Vector2()
		stop_moving = false

func stop_moving():
	stop_moving = true

func freeze():
	frozen = true

func unfreeze():
	frozen = false
