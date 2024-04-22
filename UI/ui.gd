extends CanvasLayer

@onready var menus: Control = $Menus
@onready var main_menu: Control = $Menus/MainMenu
@onready var upgrade_menu: Control = $Menus/UpgradeMenu
@onready var pause_menu: Control = $Menus/PauseMenu
@onready var result_menu: Control = $Menus/ResultMenu
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
	if Input.is_action_just_pressed("upgrade"):
		Game.game_pause.emit()
		show_upgrade_menu()

func update_hud() -> void:
	if Game.player:
		hud.get_node("Label").text = str(
			"Survival Time: ", Game.survival_time,
			"\nLevel: ", Game.player.level,
			"\nExp: ", Game.player.exp,
			"\nP: ", Game.player.upgrade_point
		)

func menus_hide() -> void:
	for menu in menus.get_children():
		menu.hide()

func game_start() -> void:
	menus_hide()
	hud.show()

func show_upgrade_menu() -> void:
	upgrade_menu.show()

func game_pause() -> void:
	pause_menu.show()
	hud.hide()

func game_resume() -> void:
	menus_hide()
	hud.show()

func game_reset() -> void:
	menus_hide()
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
