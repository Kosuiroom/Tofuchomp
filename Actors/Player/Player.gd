extends KinematicBody2D

export var speed := 200
export var armor = 4 setget set_armor

var velocity := Vector2()
var bullet_scene = preload("res://Actors/Player/Laser.tscn")

func _physics_process(_delta: float) -> void:
	var direction := Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)

	if direction.length() > 1.0:
		direction = direction.normalized()
	move_and_slide(speed * direction)
	
	if Input.is_action_just_pressed("shoot"):
		fire()


func fire():
	var bullet = bullet_scene.instance()
	bullet.direction = $Position2D.global_position - global_position
	bullet.global_position = $Position2D.global_position
	get_tree().get_root().add_child(bullet)


func set_armor(value):
	armor = value
	print("armor is: ", armor)
	if armor <= 0: 
		queue_free()
	
