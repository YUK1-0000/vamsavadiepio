class_name Bullet extends Character


func _physics_process(delta: float) -> void:
	movement(delta)
	move_and_slide()


func _on_life_timer_timeout() -> void:
	die()
