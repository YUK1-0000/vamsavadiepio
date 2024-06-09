extends Label

@export var anim_pos: Vector2

@onready var def_pos: Vector2 = global_position


func _process(_delta: float) -> void:
	global_position = def_pos + anim_pos


func _on_life_timer_timeout() -> void:
	queue_free()
