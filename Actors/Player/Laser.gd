extends Area2D

var direction := Vector2.UP;
var speed = 400

func _process(delta):
	translate(direction.normalized() * speed * delta)


func _on_Laser_body_entered(body):
	#code for applying dmg, maybe send some signal
	queue_free()
	


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
