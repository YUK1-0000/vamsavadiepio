extends CharacterBody2D

class_name Character

enum MovingMode {CONSTANT, ACCELERATION}
@export var moving_mode: MovingMode

@export var direction: Vector2
@export var speed: float
@export var acceleration: float
@export var friction: float
@export var hp_max: float
@export var level: int
@export var exp: int
@export var recoil: float
@export var damage: float
@export var knockback: float
@export var penetration: float = INF

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
	character.damaged(damage)
	character.knockedback(velocity.normalized() * knockback)
	if not penetration:
		die()
	penetration -= 1

func damaged(damage: float) -> void:
	hp = max(0, hp - damage)

func knockedback(knockback: Vector2) -> void:
	velocity += knockback

func die() -> void:
	queue_free()
