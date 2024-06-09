class_name Barrel extends Node2D

@export var bullet_scene: PackedScene

@onready var shooter: Character = get_parent()
@onready var interval_timer: Timer = $IntervalTimer

func shoot() -> void:
	if interval_timer.time_left:
			return
	# multishotの整数部回＋小数部の確率で１回の射撃
	var multishot: int = (
		int(shooter.current_stats.multishot)
		+ (
			shooter.current_stats.multishot
			- int(shooter.current_stats.multishot)
		) > randf()
	)
	for _i in range(multishot):
		var b: Bullet = bullet_scene.instantiate()
		Game.bullets.add_child(b)
		b.global_position = get_node("Muzzle").global_position
		b.rotate(
			rotation + randfn(0, shooter.current_stats.bullet_spread / 4)
			* shooter.current_stats.bullet_spread
		)
		b.direction = Vector2.RIGHT.rotated(b.rotation)
		b.current_stats.damage = shooter.current_stats.damage
		b.current_stats.knock_back = shooter.current_stats.knock_back
		b.current_stats.crit_rate = shooter.current_stats.crit_rate
		b.current_stats.crit_dmg = shooter.current_stats.crit_dmg
		# 反動
		shooter.get_knocked_back(
			Vector2.RIGHT.rotated(b.rotation + PI)
			* shooter.current_stats.recoil
		)
	interval_timer.wait_time = 100. / shooter.current_stats.fire_rate
	interval_timer.start()
