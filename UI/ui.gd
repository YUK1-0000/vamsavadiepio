extends CanvasLayer

@onready var main_menu: Control = $MainMenu
@onready var pause_menu: Control = $PauseMenu
@onready var result_menu: Control = $ResultMenu
@onready var hud: Control = $HUD

func _ready() -> void:
	Game.game_start.connect(game_start)
	Game.game_pause.connect(game_pause)
	Game.game_resume.connect(game_resume)
	Game.game_reset.connect(game_reset)
	Game.game_over.connect(game_over)

func _process(_delta: float) -> void:
	update_hud()
	if Game.is_started and Input.is_action_just_pressed("menu"):
		Game.game_pause.emit()

func update_hud() -> void:
	if Game.player:
		hud.get_node("Label").text = str(
			"Survival Time: ", Game.survival_time,
			"\nLevel: ", Game.player.level,
			"\nExp: ", Game.player.exp,
			"\nP: ", Game.player.upgrade_point
		)

func game_start() -> void:
	main_menu.hide()
	hud.show()

func game_pause() -> void:
	pause_menu.show()
	hud.hide()

func game_resume() -> void:
	pause_menu.hide()
	hud.show()

func game_reset() -> void:
	result_menu.hide()
	main_menu.show()

func game_over() -> void:
	result_menu.show()
	hud.hide()

func _on_start_button_pressed() -> void:
	Game.game_start.emit()

func _on_resume_button_pressed() -> void:
	Game.game_resume.emit()

func _on_continue_button_pressed() -> void:
	Game.game_reset.emit()
