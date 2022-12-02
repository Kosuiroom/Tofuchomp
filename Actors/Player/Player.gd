extends KinematicBody2D

export var speed := 200

var velocity := Vector2()

onready var animated_sprite: AnimatedSprite = $AnimatedSprite

func _physics_process(_delta: float) -> void:
	var direction := Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)

	if direction.length() > 1.0:
		direction = direction.normalized()
	move_and_slide(speed * direction)
