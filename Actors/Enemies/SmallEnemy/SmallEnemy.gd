extends Area2D
onready var anim = $SpriteAnimationPlayer
onready var deathsound = $deathsound
onready var colshape = $hitbox
export var velocity := Vector2()
export var speed := 200
export var armor: = 2 setget set_armor

func _process(delta):
	translate(velocity.normalized() * speed * delta)

func _on_smallenemy_body_entered(body):
	if body.is_in_group("player"):
		body.armor -= 1
		anim.play("Death")


func set_armor(value):
	armor = value
	if armor <= 0:
		deathsound.play()
		colshape.set_deferred("disabled", true)
		anim.play("Death")

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_SpriteAnimationPlayer_animation_finished(anim_name):
	if anim_name == "Death":
		queue_free()
