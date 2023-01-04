extends Control

onready var startbtn = $MenuItems/StartBar
onready var Buttonsound = $Buttonsound


func _ready():
	Global.level01_music = true
	
	startbtn.grab_focus()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func _on_StartBar_pressed():
	Global.score = 0
	get_tree().change_scene("res://GameScene/Level01.tscn")
	
func _on_ExitBar_pressed():
	get_tree().quit()


func _on_StartBar_focus_exited():
	Buttonsound.play()


func _on_ExitBar_focus_exited():
	Buttonsound.play()
