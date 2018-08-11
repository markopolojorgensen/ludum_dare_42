extends Node2D

signal casting
signal done_casting

export(NodePath) var intended_direction_path
onready var intended_direction = get_node(intended_direction_path)

var casting = false

func _ready():
	fancy_disable()

func fancy_disable():
	hide()
	$attack_body.set_collision_mask_bit(4, false)

func fancy_enable():
	show()
	$attack_body.set_collision_mask_bit(4, true)

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
	rotation = intended_direction.get_intended_direction().angle() + PI/2
