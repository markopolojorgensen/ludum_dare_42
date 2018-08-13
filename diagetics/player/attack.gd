extends Node2D

signal casting
signal done_casting

export(NodePath) var intended_direction_path
onready var intended_direction = get_node(intended_direction_path)

var target

var casting = false

func _ready():
	$attack_body.connect("body_entered", self, "body_entered")
	fancy_disable()

func body_entered(body):
	if body.has_method("is_enemy") and body.is_enemy():
		body.hit_by_player_attack()

func fancy_disable():
	hide()
	$attack_body/collision_shape_2d.disabled = true

func fancy_enable():
	show()
	$attack_body/collision_shape_2d.disabled = false

func _unhandled_input(event):
	if event.is_action_pressed("attack") and not casting and can_cast():
		casting = true
		fancy_enable()
		emit_signal("casting")
		$animation_player.play("attack")
		orient()
		
		$timer.start()
		yield($timer, "timeout")
		
		emit_signal("done_casting")
		fancy_disable()
		casting = false

func can_cast():
	return not get_parent().is_dashing()

func orient():
	if target == null:
		rotation = intended_direction.get_intended_direction().angle() + PI/2
	else:
		rotation = (target.global_position - global_position).angle() + PI/2



