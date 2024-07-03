extends Area2D

export(String, FILE, "*.tscn") var next_level

func _on_Exit_body_entered(_body):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			get_tree().change_scene(next_level)
