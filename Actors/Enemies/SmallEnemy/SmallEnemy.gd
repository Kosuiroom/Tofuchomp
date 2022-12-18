extends Area2D
onready var anim = $SpriteAnimationPlayer

export var velocity := Vector2()
export var speed := 200
export var armor: = 2 setget set_armor

func _process(delta):
	translate(velocity.normalized() * speed * delta)
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


func set_armor(value):
	armor = value
	if armor <= 0:
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
