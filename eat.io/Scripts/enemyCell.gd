extends Edible

func _ready():
	randomize()
	mass = randf_range(0.5, 2)
