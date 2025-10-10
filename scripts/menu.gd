class_name Menu
extends Control

func _on_quit_pressed() -> void:
	GameManager.quit_game()

func _on_new_game_pressed() -> void:
	GameManager.change_state(GameManager.GameState.CREATING_NEW_GAME)

func _on_options_pressed() -> void:
	GameManager.push_state(GameManager.GameState.OPTIONS)

func _on_main_menu_pressed() -> void:
	GameManager.change_state(GameManager.GameState.MAIN_MENU)

func _on_save_pressed() -> void:
	GameManager.change_state(GameManager.GameState.SAVING)

func _on_load_pressed() -> void:
	GameManager.change_state(GameManager.GameState.LOADING)

func _on_back_pressed() -> void:
	GameManager.pop_state()

func _on_apply_pressed() -> void:
	OptionsManager.options.apply()
