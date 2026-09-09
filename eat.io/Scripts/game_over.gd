extends CanvasLayer


func win():
	show()
	$PanelContainer/MarginContainer/PanelContainer/Label.text = "ALL IS CONSUMED\nALL IS UNITED\nWE FEED, WE GROW\nUNMATCHED IN THIS MATERIAL PLANE"
	$PanelContainer/MarginContainer/PanelContainer/Next.show()
#	$"PanelContainer/MarginContainer/PanelContainer/Back to menu".show()
	

func lose():
	show()
	$PanelContainer/MarginContainer/PanelContainer/Label.text = "You've been devoured\nby other organisms..."
	$PanelContainer/MarginContainer/PanelContainer/Retry.show()

func _on_restart_pressed():
	get_tree().paused = false
#	difficulty reset
	get_tree().reload_current_scene()

func _on_next_pressed():
	get_tree().paused = false
#	difficulty increase
	get_tree().reload_current_scene()

func _on_back_to_menu():
	get_tree().paused = false
#	Back to collection menu
	get_tree().change_scene_to_file("res://Scenes/hub_menu.tscn")
