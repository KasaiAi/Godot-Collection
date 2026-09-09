extends CharacterBody2D
class_name Enemy

var state = States.WANDER
enum States{WANDER, JUMP, LEAP, ATTACK}

const SPEED = 200.0
const JUMP_VELOCITY = -500.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var hp = 3

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction# = randi_range(-1, 1)
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func jump():
	if is_on_floor():
		velocity.y = JUMP_VELOCITY

func take_damage(amount: int):
	hp -= amount
	if hp <= 0:
		drop_item()
		queue_free()

#Edge behavior:
# Drop down
# Turn around
# Leap if it's short

#Land on head: take_damage()
#Pursue player
# Jump from below
# Move towards

func drop_item():
	var loot_drop = randi_range(1, 25)
	match loot_drop:
		1, 2, 3, 4, 5, 6, 7:
#			shuriken
			pass
		8, 9, 10:
#			high shuriken
			pass
		11:
#			flame shuriken
			pass
		12, 13, 14, 15, 16, 17, 18:
#			gem_low
			pass
		19, 20, 21:
#			gem_mid
			pass
		22:
#			gem_high
			pass
		23, 24:
#			extra life
			pass
		25:
#			invincible
			pass
