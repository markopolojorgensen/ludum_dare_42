extends Node2D

func _ready():
	$area_2d.connect("body_entered", self, "body_entered")

func body_entered():
	print("triggered")

