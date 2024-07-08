extends Edible

@export var MAX_SPEED = 200
var ACELLERATION = 3000
var motion = Vector2.ZERO

var TOP_DOWN = Vector2.ZERO

var debugVar = 0 #troubleshooting

func _ready():
	mass = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var axis = get_input_axis()
	if axis == Vector2.ZERO:
		apply_friction((ACELLERATION*2/3) * delta)
	else:
		apply_movement(axis * ACELLERATION * delta)
	set_velocity(motion)
	move_and_slide()
	motion = velocity
	
	for body in $EatingRoom.get_overlapping_bodies():
		if body.is_in_group("Edible"):
			feed_on(body)
	
#	print(debugVar)

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
	if mass >= opposing.mass:
		mass += 0.05
		opposing.mass -= 0.1
	else:
		mass -= 0.05
		opposing.mass += 0.1
	
	print("Player's mass is now ", mass)
#	print("Cell mass is now ", opposing.mass)

#func _on_EatingRoom_body_entered(body):
#	if body.is_in_group("Edible"):
#		feed_on(body)
