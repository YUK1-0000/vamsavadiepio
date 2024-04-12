extends CharacterBody2D

class_name Character

enum MovingMode {CONSTANT, ACCELERATION}
@export var moving_mode: MovingMode
@export var direction: Vector2
@export var speed: int
@export var acceleration: int
@export var friction: int
@export var hp_max: int
@export var level: int
@export var exp: int
@export var recoil: int
@export var damage: int
@export var knock_back: int
@export var penetration: float = INF
@export var multi_shot: float = 1
@export var crit_rate: float
@export var crit_dmg: float = 1

@onready var hp := hp_max

func movement(delta: float) -> void:
	match moving_mode:
		MovingMode.CONSTANT:
			velocity = direction * speed
		MovingMode.ACCELERATION:
			if direction:
				velocity = velocity.move_toward(direction * speed, acceleration * delta)
			else:
				velocity = velocity.move_toward(direction * speed, friction * delta)

func bump_into(character: Character) -> void:
	character.take_damage(crit_dmg * damage if randf() <= crit_rate else damage)
	character.get_knocked_back(velocity.normalized() * knock_back)
	if not penetration:
		die()
	penetration -= 1

func take_damage(dmg: float) -> void:
	hp = max(0, hp - dmg)

func get_knocked_back(kb_vec: Vector2) -> void:
	velocity += kb_vec

func die() -> void:
	queue_free()
