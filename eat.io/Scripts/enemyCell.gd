extends Edible

func _ready():
	randomize()
	mass = rand_range(0.5, 2)
