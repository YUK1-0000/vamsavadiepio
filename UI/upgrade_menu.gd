extends Control

class_name UpgradeMenu

@export var available_upgrade: Array[BaseUpgrade] = []

func _ready() -> void:
	for upgrade in available_upgrade:
		var tmp = UpgradeOption.new()
		tmp.set_upgrade_option(upgrade)
		$MarginContainer/VBoxContainer/HBoxContainer.add_child(tmp)

#func pick_random_upgrade() -> void:
	#for upgrade_option in upgrade_option_array:
		#available_upgrade.shuffle()
		#upgrade_option.set_upgrade_option(available_upgrade.pick_random())
