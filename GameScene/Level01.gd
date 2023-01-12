extends Node2D

var enemy = preload("res://Actors/Enemies/SmallEnemy/SmallEnemy.tscn")
var bigenemy = preload("res://Actors/Enemies/bigenemy/bigenemy.tscn")
var boss = preload("res://Actors/Enemies/boss/boss.tscn")
onready var spawner = $respawntimer
onready var pup = $powerupspawner
onready var level01_music = $Level01Music


var spread = preload("res://Actors/powerups/spread.tscn")
var biglaser = preload("res://Actors/powerups/biglaser.tscn")

var powerup = [
	spread,
	biglaser
]

var enemies = [
	enemy,
	bigenemy
]

func _ready():
	play_music()

func _process(_delta: float) -> void:
	if get_node("/root/Global").level01_music == false:
		stop_music()
	
		
func play_music():
	if get_node("/root/Global").level01_music == true:
		level01_music.play()
		randomize()
		
func stop_music():
		level01_music.stop()
		


func _on_respawntimer_timeout():
	var xloc = rand_range(45,970)
	var randenemy = enemies[randi() % enemies.size()]
	var e = randenemy.instance()
	add_child(e)
	e.position = Vector2(xloc,-80)
	spawner.wait_time = rand_range(0.5,1)

func _on_bossspawntimer_timeout():
	remove_child(spawner)
	remove_child(pup)
	var e = boss.instance()
	add_child(e)
	e.position = Vector2(400,-400)

func _on_powerupspawner_timeout():
	var xloc = rand_range(45,970)
	var randpup = powerup[randi() % powerup.size()]
	var e = randpup.instance()
	add_child(e)
	e.position = Vector2(xloc,-80)
