extends CenterContainer

@onready var upgrade_list: ItemList = $VBoxContainer/UpgradeList

var selected: int

func _on_upgrade_list_item_selected(index: int) -> void:
	selected = index

func _on_upgrade_button_pressed() -> void:
	if not Game.player.upgrade_point:
		return
	Game.player.upgrade_point -= 1
	match selected:
		0:
			Game.player.crit_rate += randf_range(.01, .1)
		1:
			Game.player.crit_dmg += randf_range(.02, .2)
		2:
			Game.player.fire_rate += randi_range(5, 20)
