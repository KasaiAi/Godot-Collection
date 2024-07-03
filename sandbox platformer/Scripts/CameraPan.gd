extends Node

var GameStart = false
var TweenRate = 1.5

func _ready():
	$Player/"Intro Camera".make_current()

func _input(event):
	if event is InputEventKey and GameStart == false:
		var camera = $Player/"Intro Camera"
		var camera_pan = $Player/"Intro Camera"/"Starting Pan"
		camera_pan.interpolate_callback(self, TweenRate, "SetCamera")
		camera_pan.interpolate_property(camera, "position", camera.position, Vector2(0, 0), TweenRate, Tween.TRANS_QUINT, Tween.EASE_OUT)
		camera_pan.interpolate_property(camera, "zoom", Vector2(1.2, 1.2), Vector2(1, 1), TweenRate, Tween.TRANS_QUINT, Tween.EASE_OUT)
		camera_pan.start()
		
		GameStart = true

func SetCamera():
	$Player/Main_Camera.make_current()
