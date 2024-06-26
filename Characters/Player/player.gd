class_name Player extends Character

@onready var barrel: Node2D = $Barrel
@onready var camera: Camera2D = $Camera2D

var auto_fire := false
var level: int = 0
var max_exp: int = 40
var upgrade_point: int = 0


func _ready() -> void:
	Game.game_start.connect(game_start)
	Game.game_reset.connect(disable_camera)


func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("q"):
		auto_fire = not auto_fire
	
	while current_stats.exp >= max_exp:
		level += 1
		upgrade_point += 1
		current_stats.exp = 0
		max_exp *= 1.5
	
	barrel.look_at(get_global_mouse_position())
	if auto_fire or Input.is_action_pressed("fire"):
		barrel.shoot()
	
	direction = Input.get_vector(
		"move_left",
		"move_right",
		"move_upward",
		"move_downward"
	)
	
	#regeneration(delta)
	movement(delta)
	move_and_slide()
	
	$Label.text = str(current_stats.hp)
	
	if not current_stats.hp:
		Game.game_over.emit()


func game_start() -> void:
	camera.enabled = true
	current_stats = base_stats.duplicate()


func disable_camera() -> void:
	camera.enabled = false


func die() -> void:
	Game.game_over.emit()


func upgrade(upgrade_name: String, min_rate: float, max_rate) -> void:
	if not upgrade_point:
		return
	
	upgrade_point -= 1
	var snk_name: String = upgrade_name.to_snake_case()
	current_stats.set(
		snk_name, 
		(
			current_stats.get(snk_name)
			+ base_stats.get(snk_name)
			* randf_range(min_rate, max_rate)
		)
	)
