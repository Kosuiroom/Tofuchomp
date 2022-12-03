extends Area2D

export var velocity := Vector2()
export var speed := 200
export var armor: = 2 setget set_armor

func _process(delta):
	translate(velocity.normalized() * speed * delta)


#TODO: delete enemy when it exists the screen	
#	if get_position_in_parent().y >= get_viewport_rect().size.height:
#		queue_free()

func set_armor(value):
	armor = value
	if armor <= 0:
		queue_free()

func _on_smallenemy_body_entered(body):
	print("someone touched me")
	if body.is_in_group("player"):
		body.armor -= 1
		queue_free()
