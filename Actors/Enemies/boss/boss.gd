extends Area2D

onready var sprite = $Body
export var armor: = 50 setget set_armor

##Leftgun
onready var ll_gun = $leftgun/leftleft
onready var lm_gun = $leftgun/leftmiddle
onready var lr_gun = $leftgun/leftright
onready var colshape = $CollisionShape2D
onready var headanime = $Body/Head/HeadAnimationPlayer
onready var lpawanime = $Body/PawnLeft/PawnLeftAnimationPlayer
onready var rpawanime = $Body/PawnRight/AnimationPlayer
onready var deathsound = $deathsound
onready var vicjingle = $victory
var iskilled = false

##middlegun
onready var mm_gun = $middlemiddle
onready var player = get_tree().get_nodes_in_group("player")[0]

##rightgun
onready var rl_gun = $rightgun/rightleft
onready var rm_gun = $rightgun/rightmiddle
onready var rr_gun = $rightgun/rightright
onready var mjau = $mjau
onready var laser = $lasershot
var oneshot = true

var e_laser = preload("res://Actors/Enemies/enemylaser.tscn")
var b_laser = preload("res://Actors/Enemies/enemybiglaser.tscn")

export var mvspeed = 100
var elapsed: float
export var shotcount = 10

var spread := true

func _ready():
	invinc(true)
	mjau.play()
	
func _process(delta):
	
	if iskilled:
		shot(false)
		invinc(true)
		headanime.play("Mouth")
		position = position.move_toward(Vector2(400,-200), delta * mvspeed)
		if position == Vector2(400,-200) && oneshot:
			oneshot = false
			is_killed()

	if !iskilled:
		position = position.move_toward(Vector2(400,200), delta * mvspeed)
		if position == Vector2(400,200) && !iskilled:
			invinc(false)
			elapsed += delta
			if elapsed > 0.5 and !iskilled:
				shot(true)
				elapsed = 0

func set_armor(value):
	armor = value
	if armor == 0:
		shot(false)
		iskilled = true
		deathsound.play()
		get_tree().call_group("enemylasers", "queue_free")
		
func is_killed():
	vicjingle.play()
	yield(get_tree().create_timer(2), "timeout")
	get_tree().change_scene("res://UI/Endgame.tscn")

func shot(val):
	if val:
		if shotcount <= 0:
			spread = false
		
		if spread:
			laser.play()	
			shotleft()
			shotright()
			shotcount -= 1
		else:
			laser.play()
			shotmiddle()
			spread = true
			shotcount = 10
		
func shotmiddle():
		headanime.play("Mouth")
		var bullet = b_laser.instance()
		var mshotdir = player.global_position
		bullet.direction = mshotdir - global_position
		bullet.global_position = $middlemiddle.global_position
		get_tree().get_root().add_child(bullet)
		
func shotleft():
		lpawanime.play("default")
		var Lbullet = e_laser.instance()
		var lshotdir = player.global_position
		Lbullet.direction = lshotdir - global_position
		Lbullet.global_position = ll_gun.global_position
		get_tree().get_root().add_child(Lbullet)
				
		var Mbullet = e_laser.instance()
		Mbullet.direction = lshotdir - global_position
		Mbullet.global_position = lm_gun.global_position
		get_tree().get_root().add_child(Mbullet)
				
		var Rbullet = e_laser.instance()
		Rbullet.direction = lshotdir - global_position
		Rbullet.global_position = lr_gun.global_position
		get_tree().get_root().add_child(Rbullet)
		
func shotright():
		rpawanime.play("default")
		var rshotdir = player.global_position
		var Lbullet = e_laser.instance()
		Lbullet.direction = rshotdir - global_position
		Lbullet.global_position = rl_gun.global_position
		get_tree().get_root().add_child(Lbullet)
				
		var Mbullet = e_laser.instance()
		Mbullet.direction = rshotdir - global_position
		Mbullet.global_position = rm_gun.global_position
		get_tree().get_root().add_child(Mbullet)
				
		var Rbullet = e_laser.instance()
		Rbullet.direction = rshotdir - global_position
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

func _on_HeadAnimationPlayer_animation_finished(anim_name):
	if anim_name == "Hit" && !iskilled:
		yield(get_tree().create_timer(1), "timeout")
		headanime.play("Idle")
		
	if anim_name == "Mouth" && !iskilled:
		yield(get_tree().create_timer(2), "timeout")
		headanime.play("Idle")
