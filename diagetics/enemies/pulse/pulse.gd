extends Node2D

export(Vector2) var direction = Vector2(0, 1)
export(int, "vertical", "horizontal", "both") var flip_direction = 0

var reflected = false

var max_speed = 1500
var min_speed = 0
var speed = max_speed
var speed_decay = 1.5

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
		speed -= speed * speed_decay * delta
		speed = max(speed, min_speed)

func reflected():
	if reflected:
		return
	
	speed = max_speed
	
	reflected = true
	
	$normal.hide()
	$reflected.show()
	
	if flip_direction == 1 or flip_direction == 2:
		$reflected.flip_h = true
		$hitbox.position.x *= -1
	
	if flip_direction == 0 or flip_direction == 2:
		$reflected.flip_v = true
		$hitbox.position.y *= -1
	
	# collide with enemies
	$hitbox.set_collision_mask_bit(5, true)

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



