extends Area2D

func _on_biglaser_body_entered(body):
	if body.is_in_group("player"):
		print("player took powerup")
		body.spread = false
		body.biglaser = true
		queue_free()
