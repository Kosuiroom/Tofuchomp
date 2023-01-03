extends Area2D

var direction := Vector2.UP;
var speed = 300

func _process(delta):
	translate(direction.normalized() * speed * delta)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_biglaser_area_entered(area):
	if area.is_in_group("smallenemy"):
		area.armor -= Global.dmg
		if area.armor == 0:
			Global.score += 100
		queue_free()
	elif area.is_in_group("bigenemy"):
		area.armor -= Global.dmg
		area.anim.play("Hit2")
		if area.armor == 0:
			area.anim.play("Explosion")
			Global.score += 300
		queue_free()
	elif area.is_in_group("boss"):
		area.headanime.play("Hit")
		area.armor -= Global.dmg
		if area.armor == 0:
			Global.score += 5000
		queue_free()
