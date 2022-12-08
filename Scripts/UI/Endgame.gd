extends Control

onready var startbtn = $MenuItems/Return
onready var Buttonsound = $Buttonsound
onready var finalscore = $Label
onready var background = $AudioStreamPlayer

func _ready():
	startbtn.grab_focus()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	finalscore.text = str(Global.score)
	background.play()
	
func _on_Return_pressed():
	Buttonsound.play()
	get_tree().change_scene("res://Main.tscn")
