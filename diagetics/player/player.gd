extends RigidBody2D

signal player_death
signal glub_start
signal glub_end

var previous_good_position
var resetting = false

var max_health = 10
var health = max_health

var dead = false

func _ready():
	$dash.connect("dashing", self, "dashing")
	$dash.connect("dashing", $player_sprite, "dashing")
	$dash.connect("done_dashing", $player_sprite, "done_dashing")
	
	$attack.connect("casting", self, "start_casting")
	$attack.connect("done_casting", self, "stop_casting")

func _integrate_forces(state):
	if not dead:
		$movement.do_movement(state)

func dashing():
	previous_good_position = global_position

func is_dashing():
	return $dash.dashing

func start_casting():
	if not dead and not resetting:
		stop_moving()
		$movement.freeze()
		$player_sprite.casting = true

func stop_casting():
	if not dead and not resetting:
		$movement.unfreeze()
		$player_sprite.casting = false

func got_wet(water):
	if resetting:
		return
	
	emit_signal("glub_start")
	
	$player_sprite/shadow.hide()
	
	$movement.freeze()
	
	resetting = true
	set_physics_process(false)
	
	$glub_timer.start()
	yield($glub_timer, "timeout")
	
	$wet_timer.start()
	yield($wet_timer, "timeout")
	
	global_position = previous_good_position
	
	$wet_timer.start()
	yield($wet_timer, "timeout")
	
	# take damage
	take_damage(2)
	
	$movement.unfreeze()
	$player_sprite/shadow.show()
	
	emit_signal("glub_end")
	
	set_physics_process(true)
	resetting = false

func set_target(new_target):
	$attack.target = new_target

func stop_moving():
	$movement.stop_moving()

func is_player():
	return true

func hit_by_pulse():
	take_damage(3)

func hit_by_barrier():
	take_damage(max_health + 1)

func take_damage(amount):
	health -= amount
	
	# update hud
	var percent = health / float(max_health)
	$hud/center_container/texture_progress.value = percent * 100.0
	
	if health <= 0:
		health = 0
		die()

func die():
	if not dead:
		dead = true
		stop_moving()
		$player_sprite.play("death")
		$player_sprite.fade()
		emit_signal("player_death")
		

func get_camera():
	return $camera_2d

func set_attack_target(new_target):
	$attack.target = new_target

