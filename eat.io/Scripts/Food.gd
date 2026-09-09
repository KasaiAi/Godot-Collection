extends CharacterBody2D

var mass = 0.3

func _ready():
	randomize()
	scale = Vector2(mass, mass)
