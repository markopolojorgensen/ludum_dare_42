extends Node

func _ready():
	$world/tutorial.connect("begin_fight", self, "begin_fight")

func begin_fight():
	print("let us begin")


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

