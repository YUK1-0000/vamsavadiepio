extends CanvasLayer

func _on_continue_button_pressed() -> void:
	hide()
	get_tree().paused = false
