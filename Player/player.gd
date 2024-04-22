extends Character

class_name Player

@onready var gun: Node2D = $Gun
@onready var interval_timer: Timer = $Gun/IntervalTimer
@onready var camera: Camera2D = $Camera2D

var auto_fire := false
var required_exp: int = 100
var upgrade_point: int

func _ready() -> void:
	Game.game_start.connect(enable_camera)
	Game.game_reset.connect(disable_camera)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("q"):
		auto_fire = not auto_fire
	
	while exp >= required_exp:
		upgrade_point += 1
		exp = 0
		required_exp *= 2
	
	gun.look_at(get_global_mouse_position())
	if (auto_fire or Input.is_action_pressed("fire")) and not interval_timer.time_left:
		gun.shoot()
	
	direction = Input.get_vector("move_left", "move_right", "move_upward", "move_downward")
	
	movement(delta)
	move_and_slide()
	
	$Label.text = str(hp)
	
	if not hp:
		Game.game_over.emit()

func enable_camera() -> void:
	camera.enabled = true

func disable_camera() -> void:
	camera.enabled = false
