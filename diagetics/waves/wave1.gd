extends Node2D

export(Vector2) var velocity = Vector2(5, 0)

var player

func _ready():
	$animation_player.connect("animation_finished", self, "animation_finished")
	$animation_player.play("do_the_wave")

func _process(delta):
	# 4 is the scale
	position += velocity * delta * 4
	
	var screen_size = get_viewport().size 
	if global_position.x < (player.global_position.x - (screen_size.x / 2.0) - 50):
		# wrap
		global_position.x += screen_size.x + 10

func animation_finished(name):
	queue_free()
