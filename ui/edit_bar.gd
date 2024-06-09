class_name EditBar extends Control

@export var stats_name: String

@onready var name_label: Label = $NameLabel
@onready var minus_button: Button = $MinusButton
@onready var progress_bar: ProgressBar = $CenterContainer/ProgressBar
@onready var valu_label: Label = $CenterContainer/ValuLabel
@onready var plus_button: Button = $PlusButton


func _ready() -> void:
	name_label.text = stats_name
	stats_name = stats_name.to_snake_case()
	progress_bar.value = Game.player.base_stats.get(stats_name)
	progress_bar.max_value = progress_bar.value * 2
	progress_bar.step = progress_bar.value / 5


func _on_minus_button_pressed() -> void:
	progress_bar.value -= progress_bar.step


func _on_plus_button_pressed() -> void:
	progress_bar.value += progress_bar.step


func _on_progress_bar_value_changed(value: float) -> void:
	print(value)
	Game.player.base_stats.set(stats_name, value)
	valu_label.text = str(value)
