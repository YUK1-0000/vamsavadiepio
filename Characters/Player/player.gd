extends Character

class_name Player

@onready var barrel: Node2D = $Barrel
@onready var camera: Camera2D = $Camera2D

var auto_fire := false
var max_exp: int = 40
var upgrade_point: int

func _ready() -> void:
	Game.game_start.connect(enable_camera)
	Game.game_reset.connect(disable_camera)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("q"):
		auto_fire = not auto_fire
	
	while exp >= max_exp:
		level += 1
		upgrade_point += 1
		exp = 0
		
		max_exp *= 1.5
	
	barrel.look_at(get_global_mouse_position())
	if auto_fire or Input.is_action_pressed("fire"):
		barrel.shoot()
	
	direction = Input.get_vector("move_left", "move_right", "move_upward", "move_downward")
	
	#regeneration(delta)
	movement(delta)
	move_and_slide()
	
	$Label.text = str(hp)
	
	if not hp:
		Game.game_over.emit()

func enable_camera() -> void:
	camera.enabled = true

func disable_camera() -> void:
	camera.enabled = false
