extends Area2D

var direction := Vector2.DOWN;
var speed = 400
onready var anim = $Sprite/AnimationPlayer

func _process(delta):
	anim.play("default")
	translate(direction.normalized() * speed * delta)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_enemylaser_body_entered(body):
	if body.is_in_group("player"):
		body.armor -= 1
		queue_free()
