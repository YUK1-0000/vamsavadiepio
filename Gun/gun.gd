class_name Gun
extends Node2D

@export var bullet_scene: PackedScene

@onready var shooter: Character = get_parent()

func shoot() -> void:
	var bullet: Bullet = bullet_scene.instantiate()
	bullet.global_position = get_node("Muzzle").global_position
	bullet.rotate(rotation)
	bullet.direction = Vector2.RIGHT.rotated(rotation)
	bullet.damage = shooter.damage
	bullet.knockback = shooter.knockback
	shooter.knockedback(Vector2.RIGHT.rotated(bullet.rotation + PI) * shooter.recoil)
	shooter.interval_timer.start()
	Game.bullets.add_child(bullet)
