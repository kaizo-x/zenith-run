extends Node2D

var obstacle_scene = preload("res://obstacle.tscn")
@onready var timer = $Timer
@onready var score_label = $HUD/ScoreLabel
@onready var game_over_screen = $HUD/GameOverScreen
@onready var pause_overlay = $HUD/PauseOverlay
@onready var menu_btn = $HUD/MenuButton

@onready var resume_btn = $HUD/PauseOverlay.find_child("ResumeButton", true, false)
@onready var mode_select_btn = $HUD/PauseOverlay.find_child("ModeSelectButton", true, false)
@onready var pause_restart_btn = $HUD/PauseOverlay.find_child("RestartButton", true, false)
@onready var game_over_restart_btn = $HUD/GameOverScreen.find_child("RestartButton", true, false)

var score: int = 0
var game_active: bool = true

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	update_score_ui()
	
	if pause_overlay: 
		pause_overlay.visible = false
	if game_over_screen: 
		game_over_screen.visible = false

	if menu_btn: 
		menu_btn.pressed.connect(toggle_pause)
	if resume_btn: 
		resume_btn.pressed.connect(toggle_pause)
	if mode_select_btn: 
		mode_select_btn.pressed.connect(_on_change_mode_pressed)
	if pause_restart_btn: 
		pause_restart_btn.pressed.connect(_on_restart_pressed)
	if game_over_restart_btn: 
		game_over_restart_btn.pressed.connect(_on_restart_pressed)

func toggle_pause():
	if not game_active:
		return
		
	var is_paused = !get_tree().paused
	get_tree().paused = is_paused
	
	if pause_overlay:
		pause_overlay.visible = is_paused

func add_score():
	if game_active:
		score += 1
		if score > Global.high_score:
			Global.high_score = score
		update_score_ui()

func update_score_ui():
	if score_label:
		score_label.text = "Score: " + str(score) + " | Best: " + str(Global.high_score)

func game_over():
	if not game_active:
		return
	game_active = false
	timer.stop()
	if game_over_screen:
		game_over_screen.visible = true

func _on_restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_change_mode_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://ModeSelect.tscn")

func _on_timer_timeout():
	if game_active and obstacle_scene:
		var obstacle = obstacle_scene.instantiate()
		var is_high = randf() > 0.5
		
		if is_high:
			obstacle.position = Vector2(1000, 465)
		else:
			obstacle.position = Vector2(1000, 520)
			
		add_child(obstacle)
