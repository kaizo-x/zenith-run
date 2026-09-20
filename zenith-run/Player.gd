extends CharacterBody2D

# Tuned jump physics
const JUMP_VELOCITY = -580.0 
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 1.2

# Base player scaling
const BASE_SCALE = Vector2(2.5, 2.5)
const DUCK_SCALE = Vector2(2.5, 1.25)

# Touch button states
var touch_jump: bool = false
var touch_duck: bool = false

# Microphone capture variables
var effect: AudioEffectCapture
var record_bus_index: int

func _ready():
	scale = BASE_SCALE

	var jump_btn = get_parent().get_node_or_null("HUD/JumpButton")
	var duck_btn = get_parent().get_node_or_null("HUD/DuckButton")
	
	if Global.use_voice_input:
		# Hide on-screen buttons when in Voice Mode
		if jump_btn: jump_btn.visible = false
		if duck_btn: duck_btn.visible = false
		
		# Set up audio capture bus
		record_bus_index = AudioServer.get_bus_index("Master")
		var bus_effect = AudioServer.get_bus_effect(record_bus_index, 0)
		if bus_effect is AudioEffectCapture:
			effect = bus_effect as AudioEffectCapture
	else:
		# Connect touch buttons for Touch/Keyboard Mode
		if jump_btn:
			jump_btn.pressed.connect(func(): touch_jump = true)
		if duck_btn:
			duck_btn.button_down.connect(func(): touch_duck = true)
			duck_btn.button_up.connect(func(): touch_duck = false)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	var want_jump = false
	var want_duck = false

	if Global.use_voice_input:
		# --- VOICE LOUDNESS MODE ---
		var mic_loudness = get_mic_volume()
		
		# Uncomment this line if you want to test how loud your mic inputs are in the console:
		# print("Mic Volume: ", snappedf(mic_loudness, 0.01))

		if mic_loudness > 0.15:
			want_jump = true
		elif mic_loudness > 0.04:
			want_duck = true
	else:
		# --- KEYBOARD & TOUCH MODE ---
		if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_up") or touch_jump:
			want_jump = true
			touch_jump = false
			
		if Input.is_action_pressed("ui_down") or touch_duck:
			want_duck = true

	# Perform actions
	if want_jump and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if want_duck:
		scale = DUCK_SCALE
	else:
		scale = BASE_SCALE

	move_and_slide()

func get_mic_volume() -> float:
	if not effect:
		return 0.0
		
	var frames = effect.get_buffer(effect.get_frames_available())
	if frames.size() == 0:
		return 0.0
		
	var max_amp = 0.0
	for frame in frames:
		max_amp = max(max_amp, abs(frame.x))
	return max_amp
