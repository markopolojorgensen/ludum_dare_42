extends AnimatedSprite

var dashing = false

func _process(delta):
	if get_parent().linear_velocity.x > 30:
		flip_h = false
	elif get_parent().linear_velocity.x < -30:
		flip_h = true
	
	if dashing:
		play("dash")
	elif get_parent().linear_velocity.length() > 120:
		play("run")
	else:
		play("stand")


func dashing():
	dashing = true

func done_dashing():
	dashing = false



