extends Node2D

var section_type = "big"

var sections = {
	"big": [
		preload("res://diagetics/islands/sections/island_section_1.tscn"),
	],
	"medium": [
		preload("res://diagetics/islands/sections/island_section_medium_1.tscn"),
	],
	"small": [
		preload("res://diagetics/islands/sections/island_section_small_1.tscn"),
	],
}

func _ready():
	$spawn_trigger.connect("body_entered", self, "spawn_section")
	hide()

func spawn_section(body):
	# print("new section inbound")
	var index = randi() % sections[section_type].size()
	var inst = sections[section_type][index].instance()
	add_child(inst)
	inst.global_position = $spawn_point.global_position
	
	$spawn_point.global_position += Vector2(1500, 0)
	$spawn_trigger.global_position += Vector2(1500, 0)

func activate():
	show()
