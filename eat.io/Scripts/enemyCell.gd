extends CharacterBody2D

var mass = randf_range(0.5, 2)

func _ready():
	randomize()
	scale = Vector2(mass, mass)

func _physics_process(_delta):
	for body in $EatingRoom.get_overlapping_bodies():
		if body.is_in_group("Edible"):
			feed_on(body)
	
	if mass <= 0.2:
		queue_free()

func feed_on(opposing):
	if opposing.is_in_group("Foodible"):
		mass += 0.02
		opposing.queue_free()
	elif mass >= opposing.mass:
		mass += 0.05
		opposing.mass -= 0.05
	
	scale = Vector2(mass, mass)
	opposing.scale = Vector2(opposing.mass, opposing.mass)
