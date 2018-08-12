extends Node

var parent
var location

var scenes = [
	preload("res://diagetics/enemies/pulse/pulse_down.tscn"),
	preload("res://diagetics/enemies/pulse/pulse_left.tscn"),
	preload("res://diagetics/enemies/pulse/pulse_up.tscn"),
	preload("res://diagetics/enemies/pulse/pulse_right.tscn"),
	preload("res://diagetics/enemies/pulse/pulse_up_right.tscn"),
	preload("res://diagetics/enemies/pulse/pulse_up_left.tscn"),
	preload("res://diagetics/enemies/pulse/pulse_down_right.tscn"),
	preload("res://diagetics/enemies/pulse/pulse_down_left.tscn"),
]

func attack():
	print("rar")
	for scene in scenes:
		render_attack(scene)

func limited_attack(index):
	render_attack(scenes[index])

func render_attack(scene):
	var inst = scene.instance()
	parent.add_child(inst)
	if location != null:
		inst.global_position = location.global_position
	else:
		inst.global_position = parent.global_position

