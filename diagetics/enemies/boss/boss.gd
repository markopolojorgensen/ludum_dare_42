extends Node2D

enum behavior {
	chasing,
	attacking,
	recovering,
}

var health = 300

var attack_range = 200
var player
var target

var current_state = chasing

func _ready():
	$pulse_attack.parent = get_parent()
	$pulse_attack.location = self

func _integrate_forces(state):
	update_target()
	update_speed()
	
	if current_state == chasing or current_state == recovering:
		$movement.do_movement(state)
	
	var distance = (player.global_position - global_position).length()
	if current_state == chasing and distance < attack_range:
		current_state = attacking
		pulse_attack()

func pulse_attack():
	# print("slurp")
	$ring/animated_sprite.play("suck")
	$ring/animated_sprite/suck_timer.start()
	
	yield($ring/animated_sprite/suck_timer, "timeout")
	# print("kaboom")
	$pulse_attack.attack()
	
	current_state = recovering
	$ring/animated_sprite.play("default")
	
	$recovery_timer.start()
	yield($recovery_timer, "timeout")
	if current_state == recovering:
		current_state = chasing
	

func update_target():
	match current_state:
		chasing:
			target = player.global_position
		recovering:
			if player != null:
				target = orbit_point()

func orbit_point():
	var direction_to_player = (player.global_position - global_position).normalized()
	return player.global_position - (direction_to_player * (attack_range + 100))

func update_speed():
	if player == null:
		return
	
	if target != null:
		var distance = (target - global_position).length()
		$movement.max_speed = distance

func get_intended_direction():
	if target == null:
		return Vector2()
	else:
		return (target - global_position).normalized()

func is_enemy():
	return true

func hit_by_pulse():
	damage_health(10)

func hit_by_player_attack():
	damage_health(1)

func damage_health(amount):
	health -= amount
	
	
	




