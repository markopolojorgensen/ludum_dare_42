extends Node

export(NodePath) var body_path
onready var body = get_node(body_path)

export(int) var acceleration = 3000
export(int) var max_speed = 500

export(NodePath) var intended_direction_path
onready var intended_direction = get_node(intended_direction_path)

func do_movement(state):
	var id = intended_direction.get_intended_direction()
	if id.length() > 0.1:
		# accelerate that direction
		body.apply_impulse(Vector2(), id.normalized() * acceleration * state.step)
	
	# enforce max speed
	if state.linear_velocity.length() > max_speed:
		state.linear_velocity = state.linear_velocity.normalized() * max_speed



