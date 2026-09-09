extends Node2D

@onready var foodCell = preload("res://Objects/Food.tscn")
@onready var enemyCell = preload("res://Objects/Enemy.tscn")
@onready var enemyCounter = get_node("EnemyCounter")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	spawn_cells(20)
	spawn_food(50)

func spawn_cells(amount):
	for i in range(amount):
		var C = enemyCell.instantiate()
		C.position = Vector2(randf_range(-990, 990), randf_range(-990, 990))
		enemyCounter.add_child(C)

func spawn_food(amount):
	for i in range(amount):
		var food = foodCell.instantiate()
		food.position = Vector2(randf_range(-990, 990), randf_range(-990, 990))
		add_child(food)

func _on_enemy_consumption(_node):
	if $EnemyCounter.get_children().size() == 1:
		var popup = load("res://Objects/game_over.tscn").instantiate()
		popup.win()
		add_child(popup)
		
		get_tree().paused = true
