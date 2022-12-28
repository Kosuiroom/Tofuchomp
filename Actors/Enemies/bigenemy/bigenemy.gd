extends Area2D

var e_laser = preload("res://Actors/Enemies/enemyspread.tscn")
onready var laser = $laser
onready var sprite = $Sprite
onready var anim = $Sprite/AnimationPlayer
onready var colshape = $hitbox
onready var deathsound = $deathsound
onready var attack = $attack

export var velocity := Vector2()
export var speed := 200
export var armor: = 2 setget set_armor

func _process(delta):
	translate(velocity.normalized() * speed * delta)

func _ready():
	EventBus.connect("player_laser_hit",self,"_on_player_laser_hit")
	
func _on_bigenemy_body_entered(body):
	if body.is_in_group("player"):
		body.armor -= 1
	
func _on_player_laser_hit():
#	anim.play("Hit2")
	pass

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
	if anim_name == "Hit2" && armor > 0:
		anim.play("Idle")

	if anim_name == "Explosion":
		EventBus.disconnect("player_laser_hit",self,"_on_player_laser_hit")
		sprite.visible = false
		queue_free()
	
	if anim_name == "Attack":
		anim.play("Idle")
		
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func set_armor(value):
	armor = value
	if armor <= 0:
		print("death")
		deathsound.play()
		colshape.set_deferred("disabled", true)
		attack.stop()
		anim.stop()
		anim.play("Explosion")
