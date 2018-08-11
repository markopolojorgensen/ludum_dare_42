extends Area2D

export(NodePath) var body_path
onready var body = get_node(body_path)

export(NodePath) var intended_direction_path
onready var intended_direction = get_node(intended_direction_path)

export(NodePath) var dash_path
onready var dash = get_node(dash_path)

var dash_target
var dashing = false

func _physics_process(delta):
	# print(body.linear_velocity.angle())
	if body.linear_velocity.length() > 0.1 and body.get_colliding_bodies().size() == 0:
		rotation = body.linear_velocity.angle() - PI/2
	else:
		rotation = intended_direction.get_intended_direction().angle() - PI/2
	
	if dashing and dash_target != null:
		var distance = (global_position - dash_target).length()
		# print(distance)
		if distance < 50:
			# print("cutting dash short")
			dash.dash_end()
			body.stop_moving()
			
	

func dash_begin():
	dashing = true
	var zones = get_overlapping_bodies()
	if zones.size() >= 1:
		# print("zone detected")
		intended_direction.override(zones[0].global_position - body.global_position)
		dash_target = zones[0].global_position

func dash_end():
	dashing = false
	intended_direction.clear_override()

