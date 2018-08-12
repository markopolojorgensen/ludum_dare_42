extends Node2D

export(NodePath) var player_path
onready var player = get_node(player_path)

var wave_scenes = [
	preload("res://diagetics/waves/wave1.tscn"),
	preload("res://diagetics/waves/wave2.tscn"),
	preload("res://diagetics/waves/wave3.tscn"),
]

func _ready():
	$wave_spawn_interval.connect("timeout", self, "spawn_wave")
	
	for i in range(2):
		spawn_wave()

func spawn_wave():
	var wave_index = randi() % 3
	
	var inst = wave_scenes[wave_index].instance()
	inst.player = player
	
	add_child(inst)
	
	var screen_size = get_viewport().size 
	screen_size *= 0.8 # shrink to give border
	
	var offset = Vector2()
	offset.x = (randf() * screen_size.x) - (screen_size.x / 2.0)
	offset.y = (randf() * screen_size.y) - (screen_size.y / 2.0)
	inst.global_position = player.global_position + offset

