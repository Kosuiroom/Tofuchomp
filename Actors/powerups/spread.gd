extends Area2D

export var velocity := Vector2()
export var speed := 500

func _process(delta):
	translate(velocity.normalized() * speed * delta)

func _on_spread_body_entered(body):
	if body.is_in_group("player"):
		body.spread = true
		body.biglaser = false
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
