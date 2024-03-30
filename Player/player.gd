extends Character

class_name Player

@export var bullet_scene: PackedScene

@onready var weapon := $Weapon
@onready var interval_timer := $Weapon/Timers/IntervalTimer

var auto_fire := false

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("q"):
		auto_fire != auto_fire

	weapon.look_at(get_global_mouse_position())
	if auto_fire or Input.is_action_pressed("fire"):
		fire()
	
	direction = Input.get_vector("move_left", "move_right", "move_upward", "move_downward")
	
	movement(delta)
	move_and_slide()
	death()
	$Label.text = str(hp)

func fire() -> void:
	if interval_timer.time_left:
		return
	var b: Bullet = bullet_scene.instantiate()
	b.global_position = weapon.get_node("Muzzle").global_position
	b.rotate(weapon.rotation)
	b.direction = Vector2.RIGHT.rotated(weapon.rotation)
	b.damage = damage
	b.knockback = knockback
	velocity -= Vector2.RIGHT.rotated(b.rotation) * recoil
	get_tree().root.add_child(b)
	interval_timer.start()
