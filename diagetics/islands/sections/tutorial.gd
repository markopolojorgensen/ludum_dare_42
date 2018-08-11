extends Node2D

func _ready():
	$triggers/attack_trigger.connect("triggered", self, "attack_tutorial_complete")
	$triggers/reflect_trigger.connect("triggered", self, "reflect_tutorial_complete")
	
	$triggers/attack_trigger.show()
	
	$triggers/reflect_trigger.hide()
	$hints/reflect.hide()


func attack_tutorial_complete():
	$triggers/reflect_trigger.show()
	$hints/reflect.show()
	
	$triggers/reflect_trigger.activate_attack_mode()
	
