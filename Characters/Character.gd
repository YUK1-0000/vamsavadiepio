extends CharacterBody2D

class_name Character

enum MovingMode {CONSTANT, ACCELERATION}
@export var moving_mode: MovingMode
@export var direction: Vector2
@export var speed: int
@export var acceleration: int
@export var friction: int
@export var base_hp: int
@export var hp_regen: float
@export var level: int
@export var exp: int
@export var bullet_spread: float
@export var recoil: int
@export var base_fire_rate: int
@export var base_damage: int
@export var knock_back: int
@export var penetration: float = INF
@export var base_multi_shot: float = 1
@export var base_crit_rate: float
@export var base_crit_dmg: float

@onready var hp := base_hp
@onready var max_hp := base_hp
@onready var fire_rate := base_fire_rate
@onready var damage := base_damage
@onready var multi_shot := base_multi_shot
@onready var crit_rate := base_crit_rate
@onready var crit_dmg := base_crit_dmg

func movement(delta: float) -> void:
	match moving_mode:
		MovingMode.CONSTANT:
			velocity = direction * speed
		MovingMode.ACCELERATION:
			if direction:
				velocity = velocity.move_toward(direction * speed, acceleration * delta)
			else:
				velocity = velocity.move_toward(direction * speed, friction * delta)

func regeneration(delta: float) -> void:
	#hpf += hp_regen * delta
	print(max_hp, hp + hp_regen * delta)
	return
	hp = min(max_hp, hp + hp_regen * delta)

func bump_into(character: Character) -> void:
	var crit_hit: int = int(crit_rate) + int(randf() <= crit_rate - int(crit_rate))
	var dmg := damage + damage * crit_dmg * crit_hit
	character.take_damage(dmg)
	character.get_knocked_back(velocity.normalized() * knock_back)
	Game.ui.spawn_damage_label(global_position, dmg, crit_hit)
	if not penetration:
		die()
	penetration -= 1

func take_damage(dmg: float) -> void:
	hp = max(0, hp - dmg)

func get_knocked_back(kb_vec: Vector2) -> void:
	velocity += kb_vec

func die() -> void:
	queue_free()

func upgrade(upgrade_name: String, min_rate: float, max_rate) -> void:
	var tmp := upgrade_name.to_snake_case()
	set(
		tmp, 
		get(tmp) + get("base_" + tmp) * randf_range(min_rate, max_rate)
	)
