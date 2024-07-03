extends Node2D

onready var foodCell = preload("res://Objects/Food.tscn")
onready var foodContainer = get_node("FoodContainer")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	spawn_cells(20)

func spawn_cells(amount):
	for _i in range(amount):
		var C = foodCell.instance()
		foodContainer.add_child(C)
		C.position = Vector2(rand_range(-990, 990), rand_range(-990, 990))
