extends CharacterBody2D

const SPEED = 50.0
const JUMP_VELOCITY = -400.0

var direction

func _ready() -> void:
	direction = Vector2(randi_range(-1,1),randi_range(-1,1))

func _physics_process(_delta: float) -> void:
	velocity = (direction.normalized()) * SPEED

	move_and_slide()

func damage():
	queue_free()

func _on_stage_return():
	$KillTimer.stop()

func _on_stage_exit():
	#if triggerable:
	$KillTimer.start()

func _on_killtimer_timeout() -> void:
	queue_free()
