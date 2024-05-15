extends Control

class_name UpgradeOption

@onready var upgrade_label: Label = $MarginContainer/VBoxContainer/UpgradeLabel
@onready var stats_label: Label = $MarginContainer/VBoxContainer/StatsLabel
@onready var desc_label: Label = $MarginContainer/VBoxContainer/DescLabel
@onready var purchase_button: Button = $MarginContainer/VBoxContainer/PurchaseButton

var base_null_upgrade: BaseUpgrade = null
var cost: int = 0
var min_value: float = 0
var max_value: float = 0

func _ready() -> void:
	set_upgrade_option(null)

func set_upgrade_option(upgrade: BaseUpgrade) -> void:
	print(upgrade.name)
	if upgrade == null:
		upgrade = base_null_upgrade
	upgrade_label.text = upgrade.name
	desc_label.text = upgrade.description
	purchase_button.text = "Buy(" + str(upgrade.cost) + ")"
	cost = upgrade.cost
	min_value = upgrade.min_value
	max_value = upgrade.max_value

func _on_purchase_button_pressed() -> void:
	Game.player.upgrade(name.to_lower(), min_value, max_value)
