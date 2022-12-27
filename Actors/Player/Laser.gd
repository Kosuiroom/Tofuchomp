extends Area2D

var direction := Vector2.UP;
var speed = 400

func _process(delta):
	translate(direction.normalized() * speed * delta)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Laser_area_entered(area):
	if area.is_in_group("smallenemy"):
		area.armor -= Global.dmg
		if area.armor == 0:
			Global.score += 100
		queue_free()
	elif area.is_in_group("bigenemy"):
		area.armor -= Global.dmg
		EventBus.emit_signal("player_laser_hit")
		if area.armor == 0:
			Global.score += 300
		queue_free()
	elif area.is_in_group("boss"):
		area.armor -= Global.dmg
		if area.armor == 0:
			Global.score += 5000
		queue_free()
