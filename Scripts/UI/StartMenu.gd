extends Control

onready var startbtn = $MenuItems/Start
onready var Buttonsound = $Buttonsound

func _ready():
	startbtn.grab_focus()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func _on_Start_pressed():
	Global.score = 0
	get_tree().change_scene("res://GameScene/Level01.tscn")

func _on_Exit_pressed():
	get_tree().quit()

func _on_Start_focus_exited():
#	Buttonsound.play()
	pass

func _on_Exit_focus_exited():
#	Buttonsound.play()
	pass
