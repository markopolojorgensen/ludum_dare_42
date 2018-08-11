extends RigidBody2D

var previous_good_position
var resetting = false

func _ready():
	$dash.connect("dashing", self, "dashing")
	$dash.connect("dashing", $player_sprite, "dashing")
	$dash.connect("done_dashing", $player_sprite, "done_dashing")
	
	$attack.connect("casting", self, "start_casting")
	$attack.connect("done_casting", self, "stop_casting")

func _integrate_forces(state):
	$movement.do_movement(state)

func dashing():
	previous_good_position = global_position

func is_dashing():
	return $dash.dashing

func start_casting():
	stop_moving()
	$movement.freeze()
	$player_sprite.casting = true

func stop_casting():
	$movement.unfreeze()
	$player_sprite.casting = false

func got_wet(water):
	if resetting:
		return
	
	# take damage
	print("OUCH")
	# play drowning animation
	print("GLUBGLUBGLUB")
	
	resetting = true
	set_physics_process(false)
	
	$wet_timer.start()
	yield($wet_timer, "timeout")
	
	global_position = previous_good_position
	
	$wet_timer.start()
	yield($wet_timer, "timeout")
	
	set_physics_process(true)
	resetting = false

func set_target(new_target):
	$attack.target = new_target

func stop_moving():
	$movement.stop_moving()

func is_player():
	return true

func hit_by_pulse():
	print("OW! player hit by pulse")

