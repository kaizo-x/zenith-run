extends ParallaxBackground

# Speed matches how fast your obstacles move
const SCROLL_SPEED = 50.0

func _process(delta):
	scroll_offset.x -= SCROLL_SPEED * delta
