extends Node2D

export(Vector2) var velocity = Vector2(5, 0)

func _ready():
	$animation_player.connect("animation_finished", self, "animation_finished")
	$animation_player.play("do_the_wave")
	

func _process(delta):
	# 4 is the scale
	position += velocity * delta * 4

func animation_finished(name):
	queue_free()
