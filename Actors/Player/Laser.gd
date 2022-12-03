extends Area2D

var direction := Vector2.UP;
var speed = 400

func _process(delta):
	translate(direction.normalized() * speed * delta)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Laser_area_entered(area):
	if area.is_in_group("smallenemy"):
		print("hit small")
		area.armor -= Global.dmg
		if area.armor == 0:
			Global.score += 100
			queue_free()
	elif area.is_in_group("bigenemy"):
		print("hit big")
		area.armor -= Global.dmg
		if area.armor == 0:
			Global.score += 300
			queue_free()
