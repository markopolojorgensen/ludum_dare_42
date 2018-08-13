extends Node2D

export(NodePath) var player_path
onready var player = get_node(player_path)

var min_speed = 100
var speed = min_speed
var max_speed_distance = 8000

var active = false
var glubbing = false

func _ready():
	$hitbox.connect("body_entered", self, "body_entered")
	
	$animated_sprite.frame = 0
	$animated_sprite.play("burn")
	$animated_sprite_bot.frame = 0
	$animated_sprite_bot.play("burn")
	$animated_sprite_top.frame = 0
	$animated_sprite_top.play("burn")
	
	# offset by half
	$animated_sprite2.frame = 14
	$animated_sprite2.play("burn")
	$animated_sprite_bot2.frame = 14
	$animated_sprite_bot2.play("burn")
	$animated_sprite_top2.frame = 14
	$animated_sprite_top2.play("burn")
	
	player.get_camera().limit_left = global_position.x
	
	$rumble.play()

func activate():
	active = true

func player_death():
	active = false

func boss_death():
	active = false
	$hitbox/collision_shape_2d.disabled = true
	# player.get_camera().limit_left = -10000000
	$animated_sprite.hide()
	$animated_sprite2.hide()
	$animated_sprite_bot.hide()
	$animated_sprite_bot2.hide()
	$animated_sprite_top.hide()
	$animated_sprite_top2.hide()
	
	$rumble.stop()

func _process(delta):
	# stay vertically aligned with player
	global_position.y = player.global_position.y
	
	if not active:
		return
	
	# set left camera limit
	player.get_camera().limit_left = global_position.x
	if player.global_position.x < global_position.x:
		player.hit_by_barrier()
	
	var distance = (player.global_position - global_position).length()
	if glubbing:
		speed = min_speed / 10
	elif distance > max_speed_distance:
		# print("catch up!")
		speed = distance * 2
	else:
		speed = max(distance/2, min_speed)
	
	position.x += speed * delta

func body_entered(body):
	if body.has_method("is_player") and body.is_player():
		body.hit_by_barrier()

func glub_start():
	glubbing = true

func glub_end():
	glubbing = false
