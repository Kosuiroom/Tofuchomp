extends Control

onready var startbtn = $MenuItems/Return
onready var Buttonsound = $Buttonsound
onready var finalscore = $Label

func _ready():
	startbtn.grab_focus()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
#	finalscore.text = "Final Score: " + Global.score
	
func _on_Return_pressed():
#	Buttonsound.play()
	get_tree().change_scene("res://Main.tscn")
