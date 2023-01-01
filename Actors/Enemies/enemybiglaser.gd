extends Area2D

var direction := Vector2.DOWN;
var speed = 300
onready var anim = $Sprite/AnimationPlayer

func _process(delta):
	anim.play("Attack")
	translate(direction.normalized() * speed * delta)
		
func _on_enemybiglaser_body_entered(body):
	if body.is_in_group("player"):
		body.armor -= 1
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
