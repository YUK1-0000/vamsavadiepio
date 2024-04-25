extends Area2D

class_name HitBox

enum HitType {ONCE, COOLDOWN}
@export var hit_type: HitType

@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var disable_timer: Timer = $DisableTimer

func _on_area_entered(area: HurtBox) -> void:
	var myself: Character = get_parent()
	var collided_chara: Character = area.get_parent()
	
	myself.bump_into(collided_chara)
	
	if hit_type == HitType.COOLDOWN:
		collision.call_deferred("set", "disabled", true)
		disable_timer.start()

func _on_timer_timeout() -> void:
	collision.call_deferred("set", "disabled", false)
