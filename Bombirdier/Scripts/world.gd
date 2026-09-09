extends Node2D

@onready var launchpad = $Player/Launchpad
@onready var camera = $Player/Camera2D
var max_targets:int = 50 # make 100 smaller targets

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	_spawn_check()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_player_fire(ammo) -> void:
	ammo.position = launchpad.global_position
	add_child(ammo)

func _update_ammo() -> void:
	$CanvasLayer/AmmoBar.value = $Player.ammo

func _spawn_check() -> void:
	var target_pool = $TargetContainer.get_children().size()
	if target_pool < max_targets:
		for i in max_targets - target_pool:
			spawn_target()

func spawn_target():
	var new_target = load("res://Objects/person.tscn").instantiate()
	var fixed = ["x","y"].pick_random()
	match fixed:
		"x":
			var x = [-630,630].pick_random()
			var y = randi_range(-400,350)
			new_target.position = camera.global_position + Vector2(x, y)
		"y":
			var y = [-400,350].pick_random()
			var x = randi_range(-630,630)
			new_target.position = camera.global_position + Vector2(x, y)
	#new_target.position = camera.global_position + Vector2(randi_range(-630,630),randi_range(-400,350))
	#while(new_target.position > $Player.position + Vector2(-600,-380) and new_target.position < $Player.position + Vector2(600,330)):
		#new_target.position = $Player.position + Vector2(randi_range(-630,630),randi_range(-400,350))
	$TargetContainer.add_child(new_target)
