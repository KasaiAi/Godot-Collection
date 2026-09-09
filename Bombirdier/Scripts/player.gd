extends CharacterBody2D

var direction: Vector2
var boost: int = 0
var ammo:int = 3

const SPEED = 200.0
@onready var sprite = $Birb
@onready var camera = $Camera2D

signal fire
signal updateAmmo

func _physics_process(_delta: float) -> void:
	
	direction = global_transform.basis_xform(Vector2.UP)
	
	#displace()
	
	if Input.is_action_pressed("left"):
		rotation_degrees -= 3
	elif Input.is_action_pressed("right"):
		rotation_degrees += 3
	
	velocity = direction * (SPEED + boost)
	
	move_and_slide()

func displace():
	var tween = create_tween()
	if Input.is_action_just_pressed("left"):
		tween.tween_property(sprite, "position", Vector2(150,50), 0.3)
	if Input.is_action_just_pressed("right"):
		tween.tween_property(sprite, "position", Vector2(-150,50), 0.3)
	if Input.is_action_just_released("left") or Input.is_action_just_released("right"):
		tween.tween_property(sprite, "position", Vector2(0,50), 0.3)

func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("boost"):
		boost = 200
	elif Input.is_action_pressed("brake"):
		boost = -100
	else:
		boost = 0
	
	if Input.is_action_just_pressed("bomb") and ammo > 0:
		var drop = load("res://Objects/poop.tscn").instantiate()
		drop.direction = direction
		ammo -= 1
		emit_signal("updateAmmo")
		emit_signal("fire", drop)
		$ReloadTimer.start()

func _on_reload_timeout() -> void:
	if ammo < 3:
		ammo += 1
		emit_signal("updateAmmo")
	if ammo == 3:
		$ReloadTimer.stop()
