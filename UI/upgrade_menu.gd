extends Control

class_name UpgradeMenu

@export var upgrade_option_array: Array[UpgradeOption] = []
@export var available_upgrade: Array[BaseUpgrade] = []

func pick_random_upgrade() -> void:
	for upgrade_option in upgrade_option_array:
		available_upgrade.shuffle()
		upgrade_option.set_upgrade_option(available_upgrade.pick_random())
		
