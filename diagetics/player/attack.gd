extends Node2D

var target

func _process(delta):
	if target != null:
		var direction = target.global_position - global_position
		rotation = direction.angle - PI/2


