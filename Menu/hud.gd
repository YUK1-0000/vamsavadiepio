extends CanvasLayer

func _process(_delta: float) -> void:
	$ExpLabel.text = str(Game.player.exp)
	$SurvivalTimeLabel.text = str(round(Game.survival_time * 10) / 10)
