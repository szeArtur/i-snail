class_name GameWorld
extends Node2D



@onready var camera: Camera = $Camera
@onready var player: Player = $Player
@onready var music_player = $MusicPlayer
@onready var level_root: LevelRoot = $LevelRoot
@onready var user_interface: UserInterface = $"../UserInterface"
var dialoge=true


func _ready() -> void:
	EventBus.level_completed.connect(on_level_completed)
	EventBus.restart_level.connect(restart_level)
	EventBus.menu_completed.connect(menu_comp)


func save_data() -> Dictionary:
	return {
		"level_name" : level_root.active_level_name
	}

func restart_level() -> void:
	await reset()
	level_root.restart_level()


func load_data(data : Dictionary) -> void:
	await reset()
	level_root.open(data["level_name"])


## takes one frame to reset, [param await] this method to function properly
func reset() -> void:
	level_root.close()
	player.reset()
	camera.reset()

	var previous_process_mode = process_mode
	process_mode = PROCESS_MODE_INHERIT
	await get_tree().process_frame
	process_mode = previous_process_mode


func on_level_completed() -> void:
	print("deine mom")
	await reset()
	print(level_root.current_level_index )
	if (level_root.current_level_index == 1 or level_root.current_level_index == 2) and dialoge:
		GameManager.change_state(GameManager.GameState.DIALOUQE)
		if level_root.current_level_index == 1:
			user_interface.open("dialog2")
		if level_root.current_level_index == 2:
			user_interface.open("dialog3")
	else:
		level_root.open_next_level()
		dialoge=true

func menu_comp(Name):
	print("hi")
	GameManager.change_state(GameManager.GameState.PLAYING)
	
	#user_interface.close(Name)
	dialoge=false
	on_level_completed()
	

## takes one frame to reset, [param await] this method to function properly
func create_new() -> void:

	#await reset()
	GameManager.change_state(GameManager.GameState.DIALOUQE)
	user_interface.open("dialog1")
	#level_root.restart_level()
	music_player.play()


func close() -> void:
	level_root.close()
