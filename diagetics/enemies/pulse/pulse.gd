extends Node2D

export(Vector2) var direction = Vector2(0, 1)
export(bool) var flip_horizontally = false

var reflected = false

var speed = 600

func _ready():
	$hitbox.connect("body_entered", self, "body_entered")
	$hitbox.connect("area_entered", self, "body_entered")
	$lifetime.connect("timeout", self, "fade")
	
	$normal.show()
	$reflected.hide()

func _process(delta):
	if reflected:
		position -= direction.normalized() * speed * delta
	else:
		position += direction.normalized() * speed * delta

func reflected():
	reflected = true
	
	$normal.hide()
	$reflected.show()
	
	if flip_horizontally:
		$reflected.flip_h = true
		$hitbox.position.x *= -1
	else:
		$reflected.flip_v = true
		$hitbox.position.y *= -1
		

func body_entered(body):
	if body.has_method("is_player") and body.is_player() and not reflected:
		body.hit_by_pulse()
		fade()
	
	if body.has_method("is_reflector") and body.is_reflector():
		reflected()
	
	if body.has_method("is_enemy") and body.is_enemy() and reflected:
		body.hit_by_pulse()
		fade()

func fade():
	$animation_player.play("fade")
	
	$fade_timer.start()
	yield($fade_timer, "timeout")
	
	queue_free()



