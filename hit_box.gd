extends Area2D

class_name HitBox

@export_enum("Once", "CoolDown") var HitType: int

@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var disable_timer: Timer = $DisableTimer

const ONCE := 0
const COOLDOWN := 1

func _on_area_entered(area: HurtBox) -> void:
	var attacker: Character = get_parent()
	var attacked_chara: Character = area.get_parent()
	
	attacker.attack_to(attacked_chara)
	
	if HitType == COOLDOWN:
		collision.call_deferred("set", "disabled", true)
		disable_timer.start()

func _on_timer_timeout() -> void:
	collision.call_deferred("set", "disabled", false)
