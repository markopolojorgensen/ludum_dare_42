extends Node

var parent

var scenes = [
	preload("res://diagetics/enemies/pulse/pulse_down.tscn"),
	preload("res://diagetics/enemies/pulse/pulse_left.tscn"),
]

func attack():
	for scene in scenes:
		render_attack(scene)

func limited_attack(index):
	render_attack(scenes[index])

func render_attack(scene):
	var inst = scene.instance()
	parent.add_child(inst)
	inst.global_position = parent.global_position

