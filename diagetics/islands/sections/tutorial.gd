extends Node2D

signal begin_fight

func _ready():
	$triggers/attack_trigger.connect("triggered", self, "attack_tutorial_complete")
	$triggers/reflect_trigger.connect("triggered", self, "reflect_tutorial_complete")
	$triggers/begin_trigger.connect("triggered", self, "begin_fight")
	
	$triggers/attack_trigger.show()
	
	$triggers/reflect_trigger.hide()
	$hints/reflect.hide()
	
	$islands/secret_islands.hide()
	$triggers/begin_trigger.hide()


func attack_tutorial_complete():
	$triggers/reflect_trigger.show()
	$hints/reflect.show()
	
	$triggers/reflect_trigger.activate_attack_mode()

func reflect_tutorial_complete():
	$islands/secret_islands.show()
	$triggers/begin_trigger.show()

func begin_fight():
	emit_signal("begin_fight")
