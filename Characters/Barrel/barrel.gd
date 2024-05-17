extends Node2D

class_name Gun

@export var bullet_scene: PackedScene

@onready var shooter: Character = get_parent()
@onready var interval_timer: Timer = $IntervalTimer

func shoot() -> void:
	if interval_timer.time_left:
			return
	for _i in range(int(shooter.multi_shot) + int((shooter.multi_shot - int(shooter.multi_shot)) > randf())):
		var b: Bullet = bullet_scene.instantiate()
		b.global_position = get_node("Muzzle").global_position
		b.rotate(rotation + randfn(0, shooter.bullet_spread / 4) * shooter.bullet_spread)
		b.direction = Vector2.RIGHT.rotated(b.rotation)
		b.base_damage = shooter.damage
		b.knock_back = shooter.knock_back
		b.base_crit_rate = shooter.crit_rate
		b.base_crit_dmg = shooter.crit_dmg
		Game.bullets.add_child(b)
		shooter.get_knocked_back(Vector2.RIGHT.rotated(b.rotation + PI) * shooter.recoil)
	interval_timer.wait_time = 100. / shooter.fire_rate
	interval_timer.start()
