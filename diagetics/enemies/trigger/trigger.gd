extends Node2D

signal triggered

export(bool) var attack = false

var triggered = false

func _ready():
	$trigger_area.connect("body_entered", self, "body_entered")
	$attack_timer.connect("timeout", self, "do_attack")
	
	$pulse_attack.parent = self

func do_trigger():
	if not triggered:
		triggered = true
		emit_signal("triggered")
		hide()

func body_entered(body):
	do_trigger()

func _process(delta):
	set_position(get_position())

func activate_attack_mode():
	$attack_timer.start()

func do_attack():
	$pulse_attack.limited_attack(1)
