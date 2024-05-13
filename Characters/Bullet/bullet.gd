extends Character

class_name Bullet

func _physics_process(delta: float) -> void:
	movement(delta)
	move_and_slide()

func die() -> void:
	queue_free()
