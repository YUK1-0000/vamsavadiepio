extends Control

class_name UpgradeOption

@export var base_null_upgrade: BaseUpgrade = null

@onready var upgrade_label: Label = $MarginContainer/VBoxContainer/UpgradeLabel
@onready var stats_label: Label = $MarginContainer/VBoxContainer/StatsLabel
@onready var desc_label: Label = $MarginContainer/VBoxContainer/DescLabel
@onready var purchase_button: Button = $MarginContainer/VBoxContainer/PurchaseButton

var cost: int = 0

func _ready() -> void:
	set_upgrade_option(null)

func set_upgrade_option(upgrade: BaseUpgrade) -> void:
	if upgrade == null:
		upgrade = base_null_upgrade
	upgrade_label.text = base_null_upgrade.name
	desc_label.text = base_null_upgrade.description
	purchase_button.text = "Buy(" + str(base_null_upgrade.cost) + ")"
	cost = upgrade.cost

func _on_purchase_button_pressed() -> void:
	pass # Replace with function body.
