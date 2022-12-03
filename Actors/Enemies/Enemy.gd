extends Area2D

export var velocity := Vector2()
export var speed := 200
export var armor: = 2 setget set_armor

func _process(delta):
	translate(velocity.normalized() * speed * delta)

func set_armor(value):
	armor = value
	if armor <= 0:
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
