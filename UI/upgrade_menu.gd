extends CenterContainer

@onready var upgrade_list: ItemList = $VBoxContainer/UpgradeList

var selected: String

func _on_upgrade_list_item_selected(index: int) -> void:
	selected = upgrade_list.get_item_text(index)

func _on_upgrade_button_pressed() -> void:
	if not Game.player.upgrade_point:
		return
	Game.player.upgrade_point -= 1
	match selected:
		"HP REGEN":
			Game.player.hp_regen += randf_range(.1, 1)
		"Damage":
			Game.player.damage += randi_range(1, 10)
		"CRIT Rate":
			Game.player.crit_rate += randf_range(.1, 1)
		"CRIT DMG":
			Game.player.crit_dmg += randf_range(.1, 1)
		"Fire Rate":
			Game.player.fire_rate += randi_range(5, 50)
		"Multi Shot":
			Game.player.multi_shot += randf_range(.1, 1)
