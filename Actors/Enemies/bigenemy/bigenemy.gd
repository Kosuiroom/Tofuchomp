extends "res://Actors/Enemies/Enemy.gd"

var e_laser = preload("res://Actors/Enemies/enemyspread.tscn")
onready var laser = $laser
onready var flashTimer = $FlashTimer
onready var sprite = $Sprite
onready var anim = $Sprite/AnimationPlayer

func _ready():
	EventBus.connect("player_laser_hit",self,"_on_player_laser_hit")
		
func _on_bigenemy_body_entered(body):
	if body.is_in_group("player"):
		body.armor -= 1
		
func flash():
	sprite.material.set_shader_param("flash_modifier", 1)
	flashTimer.start()

func _on_FlashTimer_timeout():
	sprite.material.set_shader_param("flash_modifier", 0)
	
func _on_player_laser_hit():
	flash()

func _on_attack_timeout():
	laser.play()
	anim.play("Attack")
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


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Attack":
		anim.play("Idle")


func _on_AnimationPlayer_animation_started(anim_name):
	print(anim_name)
