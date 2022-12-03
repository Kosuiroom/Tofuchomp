extends Area2D

onready var boss = $boss
export var velocity := Vector2()
export var speed := 200
export var armor: = 2 setget set_armor

func _process(delta):
	print("trying to move and stop boss at one place")
#	if boss.get_global_pos() <= Vector2(500,200):
#		translate(velocity.normalized() * speed * delta)
#		print("boss is walking towards stop point")

func set_armor(value):
	armor = value
	if armor <= 0:
		queue_free()
