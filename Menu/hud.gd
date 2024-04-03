extends Control

func _process(_delta: float) -> void:
	$ExpLabel.text = str(Game.player.exp)
