extends CanvasLayer

@onready var hud: Control = $HUD
@onready var main_menu: Control = $MainMenu

func _process(_delta: float) -> void:
	update_hud()

func _on_start_button_pressed() -> void:
	main_menu.hide()
	hud.show()
	Game.game_start.emit()

func update_hud() -> void:
	hud.get_node("Label").text = str(
		"Survival Time: ", Game.survival_time,
		"\nLevel: ", Game.player.level,
		"\nExp: ", Game.player.exp,
		"\nP: ", Game.player.upgrade_point
	)
