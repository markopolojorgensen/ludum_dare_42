extends Area2D

export(NodePath) var body_path
onready var body = get_node(body_path)

export(NodePath) var intended_direction_path
onready var intended_direction = get_node(intended_direction_path)

func _physics_process(delta):
	# print(body.linear_velocity.angle())
	if body.linear_velocity.length() > 0.1 and body.get_colliding_bodies().size() == 0:
		rotation = body.linear_velocity.angle() - PI/2
	else:
		rotation = intended_direction.get_intended_direction().angle() - PI/2

func dash_begin():
	var zones = get_overlapping_bodies()
	if zones.size() >= 1:
		print("zone detected")
		intended_direction.override(zones[0].global_position - body.global_position)

func dash_end():
	intended_direction.clear_override()

