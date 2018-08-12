extends Node

var boss_scene = preload("res://diagetics/enemies/boss/boss.tscn")

func _ready():
	$world/tutorial.connect("begin_fight", self, "begin_fight")

func begin_fight():
	print("let us begin")
	var inst = boss_scene.instance()
	$world.add_child(inst)
	inst.global_position = $world/boss_spawn_spot.global_position
	inst.player = $world/player


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

