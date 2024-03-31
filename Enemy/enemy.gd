extends Character

class_name Enemy

@onready var player: Player = Game.world.get_node("Player")

func _physics_process(delta: float) -> void:
	if not Game.world.has_node("Player"):
		player = null
	if player:
		direction = Vector2.RIGHT.rotated(get_angle_to(player.global_position))
	else:
		direction = Vector2.ZERO
	$Label.text = str(hp)
	movement(delta)
	move_and_slide()
	if not hp:
		die()
