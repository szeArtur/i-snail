class_name GameWorld
extends Node2D


@onready var player: Player = $Player
@onready var music_player: AudioStreamPlayer = $MusicPlayer
@onready var game_stage: GameStage = $GameStage


func _ready() -> void:
	EventBus.level_completed.connect(on_scene_completed)
	EventBus.restart_level.connect(restart)


func save_data() -> Dictionary:
	return {
		"active_scene_index": game_stage.active_scene_index
	}

func restart() -> void:
	await reset()
	game_stage.restart()


func load_data(data : Dictionary) -> void:
	await reset()
	game_stage.open(data["active_scene_index"])


## takes one frame to reset, [param await] this method to function properly
func reset() -> void:
	game_stage.close()
	player.reset()

	var previous_process_mode := process_mode
	process_mode = PROCESS_MODE_INHERIT
	await get_tree().process_frame
	process_mode = previous_process_mode


func on_scene_completed() -> void:
	await reset()
	game_stage.open_next_level()


## takes one frame to reset, [param await] this method to function properly
func create_new() -> void:
	await reset()
	game_stage.restart()
	music_player.play()


func close() -> void:
	game_stage.close()
