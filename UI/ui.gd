extends CanvasLayer

@onready var menus: Control = $Menus
@onready var main_menu: Control = $Menus/MainMenu
@onready var upgrade_menu: Control = $Menus/UpgradeMenu
@onready var pause_menu: Control = $Menus/PauseMenu
@onready var result_menu: Control = $Menus/ResultMenu
@onready var hud: Control = $HUD

const DAMAGE_LABEL_SCENE := preload("res://UI/damage_label.tscn")

func _ready() -> void:
	Game.game_start.connect(game_start)
	Game.game_resume.connect(game_resume)
	Game.game_reset.connect(game_reset)
	Game.game_over.connect(game_over)

func _process(_delta: float) -> void:
	update_hud()
	if Game.is_started and Game.is_started and Input.is_action_just_pressed("menu"):
		Game.game_pause.emit()
		show_pause_menu()
	if Game.is_started and Input.is_action_just_pressed("upgrade"):
		Game.game_pause.emit()
		show_upgrade_menu()

func update_hud() -> void:
	if Game.player:
		hud.get_node("Label").text = str(
			"Survival Time: ", Game.survival_time,
			"\nLevel: ", Game.player.level,
			"\nExp: ", Game.player.exp,
			"\nUpgrade Point: ", Game.player.upgrade_point, 
			"\nFire Rate: ", Game.player.fire_rate, 
			"\nDamage: ", Game.player.damage, 
			"\nCRIT Rate: ", Game.player.crit_rate, 
			"\nCRIT DMG: ", Game.player.crit_dmg, 
			"\nMulti Shot: ", Game.player.multi_shot
		)

func spawn_damage_label(pos: Vector2, dmg: int) -> void:
	var l: Label = DAMAGE_LABEL_SCENE.instantiate()
	l.text = str(dmg)
	l.global_position = pos
	Game.world.add_child(l)

func hide_menus() -> void:
	for menu in menus.get_children():
		menu.hide()

func game_start() -> void:
	hide_menus()
	hud.show()

func show_upgrade_menu() -> void:
	upgrade_menu.pick_random_upgrade()
	upgrade_menu.show()

func show_pause_menu() -> void:
	pause_menu.show()
	hud.hide()

func game_resume() -> void:
	hide_menus()
	hud.show()

func game_reset() -> void:
	hide_menus()
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

