extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 350

var motion = Vector2()

func _physics_process(_delta): 
	motion.y += GRAVITY
	motion.x = -SPEED
	$Sprite.play("Fall")
	rotate(-0.4)
	var circle = CircleShape2D.new()
	$Body.shape = circle
	$Base.disabled = true
	circle.radius = 10
#	Whacking sfx
#	On timer: screen fade to message
#	Message: "You broke your neck on the fall... (It was a long way down)"
#	>Whoops
#	Message2: "The curse of quitters claims another... (Only a coward runs from adventure!)"
#	>Be brave
#	Message3: "Why would you turn back after coming this far? (You had to climb those stairs, you know)"
#	>Adventure calls
		
	motion = move_and_slide(motion, UP)
	pass
