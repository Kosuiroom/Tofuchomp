extends "res://Actors/Enemies/Enemy.gd"
onready var anim = $SpriteAnimationPlayer

func _process(delta):
	if armor <= 0:
		print("small enemy died")
		anim.play("Death")

func _on_smallenemy_body_entered(body):
	if body.is_in_group("player"):
		body.armor -= 1
		queue_free()


func _on_smallenemy_area_entered(area):
	pass
#	if area.name == "Laser":
#		if area.armor <= 0:
#			print("small enemy died")
#			anim.play("Death")
