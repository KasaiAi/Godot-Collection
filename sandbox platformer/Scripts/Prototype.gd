extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 30
const ACCELERATION = 50
var MAX_SPEED = 300
const JUMP_HEIGHT = -700

var motion = Vector2()

func _physics_process(_delta): 
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_pressed("sprint"):
		MAX_SPEED = 400
	else:
		MAX_SPEED = 300
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
		$Sprite.flip_h = true
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
		$Sprite.flip_h = false
	else:
		friction = true
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.05)
		
	motion = move_and_slide(motion, UP)
	pass
