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
	var mvspeed = 20
	position = position.move_toward(Vector2(500,70), delta * mvspeed)

func set_armor(value):
	armor = value
	if armor <= 0:
		queue_free()
