extends Control

class_name UpgradeOption

@onready var name_label: Label = $MarginContainer/VBoxContainer/UpgradeLabel
@onready var stats_label: Label = $MarginContainer/VBoxContainer/StatsLabel
@onready var desc_label: Label = $MarginContainer/VBoxContainer/DescLabel
@onready var purchase_button: Button = $MarginContainer/VBoxContainer/PurchaseButton

var cost: int = 0
var min_rate: float = 0
var max_rate: float = 0

func set_upgrade_option(upgrade: BaseUpgrade) -> void:
	name_label.text = upgrade.name
	desc_label.text = upgrade.description
	purchase_button.text = "Buy(" + str(upgrade.cost) + ")"
	cost = upgrade.cost
	min_rate = upgrade.min_rate
	max_rate = upgrade.max_rate

func _on_purchase_button_pressed() -> void:
	Game.player.upgrade(name_label.text, min_rate, max_rate)
