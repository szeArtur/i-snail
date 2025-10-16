class_name GameWorld
extends Node2D


#@onready var camera: Camera = $Camera
@onready var player: Player = $Player
@onready var music_player = $MusicPlayer
@onready var level_root: LevelRoot = $LevelRoot


func _ready() -> void:
	EventBus.level_completed.connect(on_level_completed)
	EventBus.restart_level.connect(restart_level)


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
	#camera.reset()

	var previous_process_mode = process_mode
	process_mode = PROCESS_MODE_INHERIT
	await get_tree().process_frame
	process_mode = previous_process_mode


func on_level_completed() -> void:
	await reset()
	level_root.open_next_level()


## takes one frame to reset, [param await] this method to function properly
func create_new() -> void:
	await reset()
	level_root.restart_level()
	music_player.play()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_left"):
		music_player.get_stream_playback().switch_to_clip_by_name("layer1")
	
	if event.is_action_pressed("ui_right"):
		music_player.get_stream_playback().switch_to_clip_by_name("layer2")


func close() -> void:
	level_root.close()
