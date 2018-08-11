extends Area2D

func is_enemy():
	return true

func hit_by_pulse():
	get_parent().do_trigger()
