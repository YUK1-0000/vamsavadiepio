extends Character

class_name Player

@onready var gun: Node2D = $Gun
@onready var interval_timer: Timer = $Gun/IntervalTimer

var auto_fire := false
var required_exp: int = 100
var upgrade_point: int

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("menu"):
		pause()
	
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
		die()
		Game.over()

func pause() -> void:
	Game.pause_menu.show()
	get_tree().paused = true
