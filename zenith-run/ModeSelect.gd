extends Control

@onready var keyboard_btn = $KeyboardBtn
@onready var audio_btn = $AudioBtn

func _ready():
	if keyboard_btn:
		keyboard_btn.pressed.connect(_on_keyboard_selected)
	if audio_btn:
		audio_btn.pressed.connect(_on_audio_selected)

func _on_keyboard_selected():
	Global.use_voice_input = false
	get_tree().change_scene_to_file("res://Main.tscn")

func _on_audio_selected():
	Global.use_voice_input = true
	get_tree().change_scene_to_file("res://Main.tscn")
