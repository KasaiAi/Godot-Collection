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
	circle.radius = 10
	$Body.shape = circle
	$Base.disabled = true
#	Whacking sfx
#	On timer: screen fade to message
#	Message: "You broke your neck on the fall..."
#	>Whoops
#	Message2: "You had to climb those stairs, you know..."
#	>It was a long way down
#	Message3: "There's no time for hesitation!"
#	>Be brave
#	Message4: "You realize it was all a dream..."
#	>Adventure calls
		
	motion = move_and_slide(motion, UP)
	pass
