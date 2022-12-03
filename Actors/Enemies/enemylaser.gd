extends Area2D

var direction := Vector2.DOWN;
var speed = 400

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _process(delta):
	translate(direction.normalized() * speed * delta)

func _on_enemylaser_area_entered(area):
	if area.is_in_group("player"):
		area.armor -= 1
		queue_free()
