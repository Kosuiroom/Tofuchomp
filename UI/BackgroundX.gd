extends ParallaxBackground

export var scrollspeed = 100.0

func _process(delta):
	scroll_offset.x += scrollspeed * delta