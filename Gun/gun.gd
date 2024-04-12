extends Node2D

class_name Gun

@export var bullet_scene: PackedScene

@onready var shooter: Character = get_parent()

func shoot() -> void:
	var bullet: Bullet = bullet_scene.instantiate()
	bullet.global_position = get_node("Muzzle").global_position
	bullet.rotate(rotation)
	bullet.direction = Vector2.RIGHT.rotated(rotation)
	bullet.damage = shooter.damage
	bullet.knock_back = shooter.knock_back
	bullet.crit_rate = shooter.crit_rate
	bullet.crit_dmg = shooter.crit_dmg
	shooter.get_knocked_back(Vector2.RIGHT.rotated(bullet.rotation + PI) * shooter.recoil)
	shooter.interval_timer.start()
	Game.bullets.add_child(bullet)
