extends AnimatedSprite

var dashing = false
var casting = false

func _process(delta):
	if get_parent().linear_velocity.x > 30:
		flip_h = false
	elif get_parent().linear_velocity.x < -30:
		flip_h = true
	
	if get_parent().dead:
		play("death")
	elif get_parent().resetting:
		play("glub")
	elif dashing:
		play("dash")
	elif casting:
		play("cast")
	elif get_parent().linear_velocity.length() > 120:
		play("run")
	else:
		play("stand")

func dashing():
	dashing = true

func done_dashing():
	dashing = false

func fade():
	$tween.interpolate_property($fade, "modulate", Color(1,1,1,0), Color(1,1,1,0.7), 1, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	$tween.start()


