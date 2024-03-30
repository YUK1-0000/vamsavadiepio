extends Character

class_name Enemy

@onready var player: Player = $"../Player"

func _physics_process(delta: float) -> void:
	direction = Vector2.RIGHT.rotated(get_angle_to(player.global_position))
	$Label.text = str(hp)
	movement(delta)
	move_and_slide()
	death()
