extends "res://Actors/Enemies/Enemy.gd"


func _on_smallenemy_body_entered(body):
	if body.is_in_group("player"):
		body.armor -= 1
		queue_free()
