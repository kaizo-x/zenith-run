extends Control

@onready var start_button = $StartButton

func _ready():
	if start_button:
		start_button.pressed.connect(_on_start_button_pressed)

func _on_start_button_pressed():
	# Change this line to load ModeSelect.tscn!
	get_tree().change_scene_to_file("res://ModeSelect.tscn")
