extends CharacterBody2D

var jump_state = States.ON_FLOOR
enum States {ON_FLOOR, ON_AIR, DBL_JUMP}

const SPEED = 300.0
const JUMP_VELOCITY = -500.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animation = $AnimationPlayer

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if jump_state != States.DBL_JUMP:
			jump_state = States.ON_AIR
	else:
		jump_state = States.ON_FLOOR

	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			jump_state = States.ON_AIR
		elif not is_on_floor():
			if jump_state == States.ON_AIR:
				velocity.y = JUMP_VELOCITY
				jump_state = States.DBL_JUMP

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		$Sprite2D.scale.x = direction
		$meleeArea.scale.x = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _input(event : InputEvent):
	if event.is_action_pressed("down"):
		position.y += 1
	if event.is_action_pressed("attack"):
		var melee_check = $"meleeArea".get_overlapping_bodies()
		if melee_check:
			for enemy in melee_check:
				enemy.take_damage(5)
		else:
			ranged_attack()

func ranged_attack():
	var ranged_check = $rangedArea.get_overlapping_bodies()
	if ranged_check.size() == 0:
		return
	
	if jump_state == States.DBL_JUMP:
		for enemy in ranged_check:
			shoot(enemy)
	else:
		var target: Object = null
		var closest: float = 200
		for enemy in ranged_check:
			if position.distance_to(enemy.position) < closest:
				target = enemy
				closest = position.distance_to(enemy.position)
		shoot(target)

func shoot(target):
	target.take_damage(1)
	pass
