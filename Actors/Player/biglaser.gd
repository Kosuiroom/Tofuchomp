extends Area2D

var direction := Vector2.UP;
var speed = 300

func _process(delta):
	translate(direction.normalized() * speed * delta)

func _on_VisibilityNotifier2D_viewport_exited(_viewport):
		queue_free()


func _on_biglaser_area_entered(area):
	if area.is_in_group("enemy"):
		area.armor -= Global.dmg
		queue_free()
