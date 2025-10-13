extends Node


@onready var game_world: GameWorld = $GameWorld
@onready var user_interface: CanvasLayer = $UserInterface


func _ready():
	GameManager.state_changed.connect(_on_game_state_changed)
	GameManager.change_state(GameManager.GameState.MAIN_MENU)


func _on_game_state_changed(state_new):
	match state_new:
		GameManager.GameState.DIALOUQE:
			game_world.process_mode = PROCESS_MODE_DISABLED
			game_world.hide()
			user_interface.close()
			#user_interface.open("dialog1")
			
		GameManager.GameState.CREATING_NEW_GAME:
			GameManager.change_state(GameManager.GameState.PLAYING)
			game_world.create_new()
			

		GameManager.GameState.PLAYING:
			game_world.process_mode = PROCESS_MODE_INHERIT
			game_world.show()
			user_interface.close()

		GameManager.GameState.PAUSED:
			game_world.process_mode = PROCESS_MODE_DISABLED
			user_interface.close()
			user_interface.open("pause")

		GameManager.GameState.OPTIONS:
			user_interface.close()
			user_interface.open("options")

		GameManager.GameState.MAIN_MENU:
			game_world.process_mode = PROCESS_MODE_DISABLED
			OptionsManager.options.apply()
			game_world.hide()
			game_world.close()
			user_interface.close()
			user_interface.open("main")
		
		GameManager.GameState.RELOADING:
			await game_world.restart_level()
			GameManager.change_state(GameManager.GameState.PLAYING)

		GameManager.GameState.LOADING:
			await SaveManager.load_game()
			GameManager.change_state(GameManager.GameState.PLAYING)

		GameManager.GameState.SAVING:
			SaveManager.save_game()
			GameManager.change_state(GameManager.GameState.PLAYING)
