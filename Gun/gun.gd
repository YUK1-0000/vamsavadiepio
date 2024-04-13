extends Node2D

class_name Gun

@export var bullet_scene: PackedScene

@onready var shooter: Character = get_parent()

func shoot() -> void:
	var b: Bullet = bullet_scene.instantiate()
	b.global_position = get_node("Muzzle").global_position
	b.rotate(rotation)
	b.direction = Vector2.RIGHT.rotated(rotation)
	b.damage = shooter.damage
	b.knock_back = shooter.knock_back
	b.crit_rate = shooter.crit_rate
	b.crit_dmg = shooter.crit_dmg
	shooter.get_knocked_back(Vector2.RIGHT.rotated(b.rotation + PI) * shooter.recoil)
	shooter.interval_timer.start()
	Game.bullets.add_child(b)
