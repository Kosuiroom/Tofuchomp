extends Area2D

onready var sprite = $Sprite
export var velocity := Vector2()
export var armor: = 50 setget set_armor

##Leftgun
onready var ll_gun = $leftgun/leftleft
onready var lm_gun = $leftgun/leftmiddle
onready var lr_gun = $leftgun/leftright
onready var colshape = $CollisionShape2D
var is_invinc = false

##middlegun
onready var mm_gun = $middlegun/middlemiddle

##rightgun
onready var rl_gun = $rightgun/rightleft
onready var rm_gun = $rightgun/rightmiddle
onready var rr_gun = $rightgun/rightright

var e_laser = preload("res://Actors/Enemies/enemylaser.tscn")
var b_laser = preload("res://Actors/Enemies/enemybiglaser.tscn")
export var mvspeed = 20
var elapsed: float

var spread := true
	
func _process(delta):
	position = position.move_toward(Vector2(500,70), delta * mvspeed)
	
	if position == Vector2(500,70):
		invinc(false)
		elapsed += delta

		if elapsed > 1.25:
			shot()
			elapsed = 0
	else:
		invinc(true)

func set_armor(value):
	armor = value
	if armor <= 0:
		queue_free()

func shot():
	if spread:	
		shotleft()
		shotright()
	else:
		shotmiddle()
		
func shotmiddle():
		print("Shooting middle")
		var mlbullet = b_laser.instance()
		mlbullet.direction = mm_gun.global_position - global_position
		mlbullet.global_position = mm_gun.global_position
		get_tree().get_root().add_child(mlbullet)
		
func shotleft():
		var Lbullet = e_laser.instance()
		Lbullet.direction = ll_gun.global_position - global_position
		Lbullet.global_position = ll_gun.global_position
		get_tree().get_root().add_child(Lbullet)
				
		var Mbullet = e_laser.instance()
		Mbullet.direction = lm_gun.global_position - global_position
		Mbullet.global_position = lm_gun.global_position
		get_tree().get_root().add_child(Mbullet)
				
		var Rbullet = e_laser.instance()
		Rbullet.direction = lr_gun.global_position - global_position
		Rbullet.global_position = lr_gun.global_position
		get_tree().get_root().add_child(Rbullet)
		
func shotright():
		var Lbullet = e_laser.instance()
		Lbullet.direction = rl_gun.global_position - global_position
		Lbullet.global_position = rl_gun.global_position
		get_tree().get_root().add_child(Lbullet)
				
		var Mbullet = e_laser.instance()
		Mbullet.direction = rm_gun.global_position - global_position
		Mbullet.global_position = rm_gun.global_position
		get_tree().get_root().add_child(Mbullet)
				
		var Rbullet = e_laser.instance()
		Rbullet.direction = rr_gun.global_position - global_position
		Rbullet.global_position = rr_gun.global_position
		get_tree().get_root().add_child(Rbullet)
		
func invinc(val):
	if val:
		colshape.set_deferred("disabled", true)
	else:
		colshape.set_deferred("disabled", false)

func _on_boss_body_entered(body):
	if body.is_in_group("player"):
		if body.armor > 0:
			body.armor -= 1
