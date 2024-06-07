class_name Character extends CharacterBody2D

@export var base_stats: CharacterStats

@onready var current_stats := base_stats.duplicate()

var direction: Vector2

func movement(delta: float) -> void:
	match current_stats.moving_mode:
		current_stats.MovingMode.CONSTANT:
			velocity = direction * current_stats.speed
		current_stats.MovingMode.ACCELERATION:
			if direction:
				velocity = velocity.move_toward(
					direction * current_stats.speed, current_stats.acceleration * delta
				)
			else:
				velocity = velocity.move_toward(
					direction * current_stats.speed, current_stats.friction * delta
				)

func regeneration(delta: float) -> void:
	# 未実装
	pass

func bump_into(character: Character) -> void:
	var crit_hit: int = (
		int(current_stats.crit_rate)
		+ int(
			randf() <= current_stats.crit_rate
			- int(current_stats.crit_rate)
		)
	)
	var dmg = current_stats.damage * (1 + current_stats.crit_dmg * crit_hit)
	character.take_damage(dmg)
	character.get_knocked_back(velocity.normalized() * current_stats.knock_back)
	Game.ui.spawn_damage_label(global_position, dmg, crit_hit)
	if not current_stats.penetration:
		die()
	current_stats.penetration -= 1

func take_damage(dmg: float) -> void:
	current_stats.hp = max(0, current_stats.hp - dmg)

func get_knocked_back(kb_vec: Vector2) -> void:
	velocity += kb_vec

func die() -> void:
	queue_free()

func upgrade(upgrade_name: String, min_rate: float, max_rate) -> void:
	# 要作り直し
	var tmp := upgrade_name.to_snake_case()
	set(
		tmp, 
		get(tmp) + get("base_" + tmp) * randf_range(min_rate, max_rate)
	)
