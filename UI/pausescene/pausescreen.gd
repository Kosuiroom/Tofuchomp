extends Control

var is_paused = false setget set_is_paused

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		self.is_paused = !is_paused
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func set_is_paused(val):
	is_paused = val
	get_tree().paused = is_paused
	visible = is_paused

func _on_Continue_pressed():
	self.is_paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_Exit_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Main.tscn")
