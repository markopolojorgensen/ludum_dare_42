extends Node2D

signal casting
signal done_casting

export(NodePath) var intended_direction_path
onready var intended_direction = get_node(intended_direction_path)

var casting = false

func _ready():
	hide()

func _unhandled_input(event):
	if event.is_action_pressed("attack") and not casting and can_cast():
		casting = true
		show()
		emit_signal("casting")
		$animation_player.play("attack")
		orient()
		
		$timer.start()
		yield($timer, "timeout")
		
		emit_signal("done_casting")
		hide()
		casting = false

func can_cast():
	return not get_parent().is_dashing()

func orient():
	rotation = intended_direction.get_intended_direction().angle() + PI/2
