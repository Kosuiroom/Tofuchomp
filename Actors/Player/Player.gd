extends KinematicBody2D

export var speed := 200
export var armor = 1 setget set_armor

var velocity := Vector2()
var e_laser = preload("res://Actors/Player/Laser.tscn")
var e_biglaser = preload("res://Actors/Player/biglaser.tscn")
var e_spread = preload("res://Actors/Player/spread.tscn")
onready var Anime = $AnimationPlayer
onready var lasersound = $lasersound
onready var barkingsound = $Barkingsound
var spread = false
var biglaser:= false

func _physics_process(_delta: float) -> void:
	var direction := Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	
	if Input.is_action_pressed("move_right"):
		Anime.play("Turn_Right")
	if Input.is_action_pressed("move_left"):
		Anime.play("Turn_Left")
		
	
	if direction == Vector2(0,0):
		Anime.play("Idle")

	if direction.length() > 1.0:
		direction = direction.normalized()
	move_and_slide(speed * direction)
	
	if Input.is_action_just_pressed("shoot"):
		lasersound.play()
		fire()
	if Input.is_action_just_pressed("Bark"):
		barkingsound.play()

func fire():
	if spread:
		Global.dmg = 1
		var Lbullet = e_spread.instance()
		Lbullet.direction = $left.global_position - global_position
		Lbullet.global_position = $left.global_position
		get_tree().get_root().add_child(Lbullet)
		
		var Mbullet = e_spread.instance()
		Mbullet.direction = $middle.global_position - global_position
		Mbullet.global_position = $middle.global_position
		get_tree().get_root().add_child(Mbullet)
		
		var Rbullet = e_spread.instance()
		Rbullet.direction = $right.global_position - global_position
		Rbullet.global_position = $right.global_position
		get_tree().get_root().add_child(Rbullet)
	elif biglaser:
		Global.dmg = 4
		var bullet = e_biglaser.instance()
		bullet.direction = $middle.global_position - global_position
		bullet.global_position = $middle.global_position
		get_tree().get_root().add_child(bullet)
	else:
		Global.dmg = 1
		var bullet = e_laser.instance()
		bullet.direction = $middle.global_position - global_position
		bullet.global_position = $middle.global_position
		get_tree().get_root().add_child(bullet)

func set_armor(value):
	armor = value
	if armor <= 0: 
		is_killed()
		
func is_killed():
	yield(get_tree().create_timer(1), "timeout")
	get_tree().change_scene("res://UI/Endgame.tscn")
