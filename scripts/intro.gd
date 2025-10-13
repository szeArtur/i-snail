extends VideoStreamPlayer

func switch_to_menu() -> void:
	GameManager.change_state(GameManager.GameState.MAIN_MENU)
