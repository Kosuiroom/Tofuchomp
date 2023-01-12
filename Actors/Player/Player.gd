extends KinematicBody2D

export var speed := 200
export var armor = 1 setget set_armor

var velocity := Vector2()
var e_laser = preload("res://Actors/Player/Laser.tscn")
var e_biglaser = preload("res://Actors/Player/biglaser.tscn")
var e_spread = preload("res://Actors/Player/spread.tscn")
var level01 = preload("res://GameScene/Level01.gd")

onready var Anime = $Player/AnimationPlayer
onready var lasersound = $lasersound
onready var barkingsound = $Barkingsound
onready var losingsound = $Losingsound
onready var colshape = $CollisionShape2D
var spread = false
var biglaser:= false

var iskilled := false
var playonce := true

func _physics_process(_delta: float) -> void:
	
	if armor == 0:
		playonce = false
#		colshape.set_deferred("disabled", true)
		yield(get_tree().create_timer(1.5), "timeout")
		get_tree().change_scene("res://UI/Endgame.tscn")
		
	
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
	if armor == 0:
		colshape.set_deferred("disabled", true)
		get_node("/root/Global").level01_music = false
		losingsound.play()
		Anime.play("PlayerDeath")
#func is_killed():
#	print("iskilled")
#	colshape.set_deferred("disabled", true)
#	get_tree().change_scene("res://UI/Endgame.tscn")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "PlayerDeath":
		pass
