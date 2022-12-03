extends Area2D

export var velocity := Vector2()
export var speed := 200

#func _process(delta):
#	translate(velocity.normalized() * speed * delta)

#TODO: delete enemy when it exists the screen	
#	if get_position_in_parent().y >= get_viewport_rect().size.height:
#		queue_free()
