extends Node2D

signal boss_death
signal phase_1_end
signal phase_2_end

enum behavior {
	chasing,
	attacking,
	recovering,
	dead,
}

var phase = 1

var max_health = 200
var health = max_health

var attack_range = 300
var player
var target

var current_state = chasing

var glubbing = false

# respect camera limits!
var limits = [-650, 900]

func _ready():
	$pulse_attack.parent = get_parent()
	$pulse_attack.location = self
	$hover.play()

func _integrate_forces(state):
	if current_state == dead:
		return
	
	update_target()
	update_speed()
	
	# if current_state == chasing or current_state == recovering:
	$movement.do_movement(state)
	
	var distance = (player.global_position - global_position).length()
	if current_state == chasing and distance < attack_range and not glubbing:
		current_state = attacking
		pulse_attack()

func pulse_attack():
	# print("slurp")
	$ring/inner_ring.play("suck")
	$suck.play()
	$ring/inner_ring/suck_timer.start()
	
	yield($ring/inner_ring/suck_timer, "timeout")
	
	$ring/inner_ring.play("default")
	
	if current_state == dead:
		return # don't finish attack if dying
	
	$pulse_attack.attack()
	$blast.play()
	
	current_state = recovering
	
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
				target = orbit_point() + Vector2(50, 0)
		attacking:
			target = global_position + Vector2(100, 0)
	
	if global_position.x < player.global_position.x:
		target.x += 600
	else:
		var weight = (global_position.x - player.global_position.x) / 200.0
		target.x += lerp(600, 0, weight)
	
	while target.y > limits[1]:
		target.y -= 50
	
	while target.y < limits[0]:
		target.y += 50


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
	# print("boss hit by pulse")
	damage_health(10)

func hit_by_player_attack():
	damage_health(1)

func damage_health(amount):
	health -= amount
	
	var percent = health / float(max_health)
	$boss_hud/center_container/texture_progress.value = percent * 100.0
	
	if phase == 1 and percent < 0.67:
		phase = 2
		emit_signal("phase_1_end")
	elif phase == 2 and percent < 0.33:
		phase = 3
		emit_signal("phase_2_end")
	
	if health <= 0 and current_state != dead:
		current_state = dead
		
		$ring.play("death")
		$animation_player.stop()
		$animation_player.play("death")
		$camera_2d.current = true
		emit_signal("boss_death")
		$hover.stop()
	elif health > 0 and current_state != dead:
		$animation_player.play("flash")

func glub_start():
	glubbing = true

func glub_end():
	glubbing = false



