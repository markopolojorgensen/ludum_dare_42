extends Area2D

func _ready():
	connect("body_entered", self, "body_entered")

func body_entered(body):
	if body.has_method("got_wet"):
		body.got_wet(self)

