extends CanvasLayer

func _process(_delta: float) -> void:
	$SurvivalTimeLabel.text = str(round(Game.survival_time * 10) / 10)
	$Label.text = str(
		"Level: ", Game.player.level,
		"\nExp: ", Game.player.exp,
		"\nP: ", Game.player.upgrade_point
	)
