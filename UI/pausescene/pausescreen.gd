extends Control

var is_paused = false setget set_is_paused
onready var startbtn = $CenterContainer/VBoxContainer/Continue
onready var Buttonsound = $CenterContainer/VBoxContainer/Buttonsound


		
func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		self.is_paused = !is_paused
		startbtn.grab_focus()
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


func _on_Continue_focus_exited():
	Buttonsound.play()


func _on_Exit_focus_exited():
	Buttonsound.play()
