extends CharacterBody2D

@export var MAX_SPEED = 200
var ACELLERATION = 3000
var motion = Vector2.ZERO

var TOP_DOWN = Vector2.ZERO

var debugVar = 0 #troubleshooting

var mass = 1

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var axis = get_input_axis()
	if axis == Vector2.ZERO:
		apply_friction((ACELLERATION) * delta)
	else:
		apply_friction((ACELLERATION*2/3) * delta)
		apply_movement(axis * ACELLERATION * delta)
	set_velocity(motion)
	move_and_slide()
	
	for body in $EatingRoom.get_overlapping_bodies():
		if body.is_in_group("Edible") and body != self:
			feed_on(body)
	
	if mass <= 0.2:
		scale = Vector2(0, 0)
		mass = 1
		
		var popup = load("res://Objects/game_over.tscn").instantiate()
		popup.lose()
		add_child(popup)
		
		get_tree().paused = true

func get_input_axis():
	var axis = Vector2.ZERO
	axis.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	axis.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	return axis.normalized()

func apply_friction(amount):
	if motion.length() > amount:
		motion -= motion.normalized() * amount
	else:
		motion = Vector2.ZERO

func apply_movement(acceleration):
	motion += acceleration
	motion = motion.limit_length(MAX_SPEED)

func feed_on(opposing):
	if opposing.is_in_group("Foodible"):
		mass += 0.02
		opposing.queue_free()
	elif mass >= opposing.mass:
		mass += 0.01
		opposing.mass -= 0.1
	
	scale = Vector2(mass, mass)
	opposing.scale = Vector2(opposing.mass, opposing.mass)
	
#	print("Player's mass is now ", mass)
#	print("Cell mass is now ", opposing.mass)
