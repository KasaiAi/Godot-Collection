extends KinematicBody2D
class_name Edible

var mass #troubleshooting

func _physics_process(_delta):
	if mass <= 0.1:
		queue_free()
#		If queued object is player, stop processes and display
#		GAME OVER

	scale = Vector2(mass, mass)
