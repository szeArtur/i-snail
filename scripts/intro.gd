extends VideoStreamPlayer

var dissolve := false


func _process(delta: float) -> void:
	if dissolve:
		modulate = lerp(modulate, Color.TRANSPARENT, delta * 2)

func _on_finished() -> void:
	queue_free()


func _on_timer_timeout() -> void:
	GameManager.change_state(GameManager.GameState.MAIN_MENU)
	dissolve = true
