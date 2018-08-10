extends RigidBody2D

func _integrate_forces(state):
	$movement.do_movement(state)
