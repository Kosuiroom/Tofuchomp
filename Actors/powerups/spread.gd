extends Area2D

func _on_spread_body_entered(body):
	if body.is_in_group("player"):
		body.spread = true
		body.biglaser = false
		queue_free()
