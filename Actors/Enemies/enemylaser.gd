extends Area2D

var direction := Vector2.DOWN;
var speed = 400

func _process(delta):
	translate(direction.normalized() * speed * delta)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_enemylaser_body_entered(body):
	print("something entered: ", body)
	if body.is_in_group("player"):
		body.armor -= 1
		queue_free()
