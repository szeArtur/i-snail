extends VideoStreamPlayer

func switch_to_menu() -> void:
	GameManager.change_state(GameManager.GameState.MAIN_MENU)


func _unhandled_key_input(_event: InputEvent) -> void:
	$AnimationPlayer.play("skip")
