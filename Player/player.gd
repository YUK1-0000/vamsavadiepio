extends Character

class_name Player

@export var bullet_scene: PackedScene

@onready var gun := $Gun
@onready var interval_timer := $Gun/Timers/IntervalTimer

var auto_fire := false

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("menu"):
		pause()
	
	if Input.is_action_just_pressed("q"):
		auto_fire != auto_fire
	
	gun.look_at(get_global_mouse_position())
	if auto_fire or Input.is_action_pressed("fire") and not interval_timer.time_left:
		fire()
	
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

func fire() -> void:
	var b: Bullet = bullet_scene.instantiate()
	b.global_position = gun.get_node("Muzzle").global_position
	b.rotate(gun.rotation)
	b.direction = Vector2.RIGHT.rotated(gun.rotation)
	b.damage = damage
	b.knockback = knockback
	velocity -= Vector2.RIGHT.rotated(b.rotation) * recoil
	Game.bullets.add_child(b)
	interval_timer.start()
