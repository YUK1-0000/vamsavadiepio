extends Control

class_name UpgradeMenu

@export var upgrade_options: Array[UpgradeOption] = []
@export var available_upgrades: Array[BaseUpgrade] = []


func _ready() -> void:
	var i := 0
	for upgrade in available_upgrades:
		upgrade_options[i].set_upgrade_option(upgrade)
		i += 1


#func pick_random_upgrade() -> void:
	#for upgrade_option in upgrade_option_array:
		#available_upgrade.shuffle()
		#upgrade_option.set_upgrade_option(available_upgrade.pick_random())
