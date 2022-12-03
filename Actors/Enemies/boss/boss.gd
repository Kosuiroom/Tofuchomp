extends Area2D

onready var sprite = $Sprite
export var velocity := Vector2()
export var speed := 200
export var armor: = 2 setget set_armor

var point1 = Vector2(500,70)
var point2 = Vector2(500,200)
var time = 0
var timeDirection = 1
var moveDuration = 2
	
func _process(delta):
	# Moves to Vector(0,0) at a speed of 1 unit per second
	var speed = 20 # Change this to increase it to more units/second
	position = position.move_toward(Vector2(500,70), delta * speed)

func set_armor(value):
	armor = value
	if armor <= 0:
		queue_free()
