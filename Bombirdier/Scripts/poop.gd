extends CharacterBody2D

@onready var sprite = $Sprite2D
var direction

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	sprite.scale -= Vector2(.004, .004)
	
	velocity = direction * 100
	move_and_slide()


func _on_timer_timeout() -> void:
	for target in $Area2D.get_overlapping_bodies():
		if target.is_in_group("target"):
			target.damage()
	queue_free()
