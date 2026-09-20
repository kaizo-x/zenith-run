extends Area2D

const SPEED = 300.0
var counted: bool = false

func _ready():
	body_entered.connect(_on_body_entered)

func _process(delta):
	position.x -= SPEED * delta

	if not counted and position.x < 100:
		counted = true
		var main_node = get_tree().current_scene
		if main_node and main_node.has_method("add_score"):
			main_node.add_score()

	if position.x < -100:
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("player") or body.name == "Player":
		var main_node = get_tree().current_scene
		if main_node and main_node.has_method("game_over"):
			main_node.game_over()
