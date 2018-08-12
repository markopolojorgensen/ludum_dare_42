extends Node

var boss_scene = preload("res://diagetics/enemies/boss/boss.tscn")

func _ready():
	$world/tutorial.connect("begin_fight", self, "begin_fight")
	$world/player.connect("player_death", self, "player_death")
	$world/player.connect("glub_start", $world/lightning_barrier, "glub_start")
	$world/player.connect("glub_end", $world/lightning_barrier, "glub_end")

func begin_fight():
	print("let us begin")
	var inst = boss_scene.instance()
	$world.add_child(inst)
	inst.global_position = $world/boss_spawn_spot.global_position
	inst.player = $world/player
	
	$world/player.set_target(inst)
	
	$world/lightning_barrier.activate()
	$world/section_manager.activate()

func player_death():
	$world/lightning_barrier.player_death()


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

