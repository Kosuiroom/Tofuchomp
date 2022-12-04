extends "res://Actors/Enemies/Enemy.gd"

var e_laser = preload("res://Actors/Enemies/enemylaser.tscn")

func _ready():
	yield(get_tree().create_timer(1), "timeout")
	shot()

func shot():
	while true:
		var Lbullet = e_laser.instance()
		Lbullet.direction = $left.global_position - global_position
		Lbullet.global_position = $left.global_position
		get_tree().get_root().add_child(Lbullet)
		
		var Mbullet = e_laser.instance()
		Mbullet.direction = $middle.global_position - global_position
		Mbullet.global_position = $middle.global_position
		get_tree().get_root().add_child(Mbullet)
		
		var Rbullet = e_laser.instance()
		Rbullet.direction = $right.global_position - global_position
		Rbullet.global_position = $right.global_position
		get_tree().get_root().add_child(Rbullet)
		
		yield(get_tree().create_timer(1.25), "timeout")

func _on_bigenemy_body_entered(body):
	print("player hit big enemy")
	if body.is_in_group("player"):
		body.armor -= 1
