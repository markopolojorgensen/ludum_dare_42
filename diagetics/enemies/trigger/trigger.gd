extends Node2D

signal triggered

export(bool) var attack = false

var triggered = false

var activated = false

func _ready():
	$trigger_area.connect("body_entered", self, "body_entered")
	$trigger_area.connect("area_entered", self, "body_entered")
	$attack_timer.connect("timeout", self, "do_attack")
	
	$pulse_attack.parent = self

func do_trigger():
	if not triggered:
		triggered = true
		emit_signal("triggered")
		hide()
		$trigger_area.set_collision_mask_bit(4, false)

func body_entered(body):
	do_trigger()

func _process(delta):
	if activated:
		$countdown.text = str(ceil($attack_timer.time_left))
	
	set_position(get_position())

func activate_attack_mode():
	$attack_timer.start()
	activated = true

func do_attack():
	$pulse_attack.limited_attack(1)
