extends Node2D

var enemy = preload("res://Actors/Enemies/SmallEnemy/SmallEnemy.tscn")
var bigenemy = preload("res://Actors/Enemies/bigenemy/bigenemy.tscn")

var enemies = [
	enemy,
	bigenemy
]

func _ready():
	randomize()

func _on_respawntimer_timeout():
	var xloc = rand_range(45,970)
	var randenemy = enemies[randi() % enemies.size()]
	var e = randenemy.instance()
	add_child(e)
	e.position = Vector2(xloc,-80)
	$respawntimer.wait_time = rand_range(0.5,1)


func _on_bossspawntimer_timeout():
	pass # Replace with function body.