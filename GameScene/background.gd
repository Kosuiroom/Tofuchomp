extends ParallaxBackground

export var scrollspeed = 100.0

func _process(delta):
#	scroll_base_offset += Vector2(0,100) * delta
	scroll_offset.y += scrollspeed * delta
