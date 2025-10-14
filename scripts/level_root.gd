class_name LevelRoot
extends Node2D


var active_level: Level
var active_level_name: StringName

@onready var player: Player = $"../Player"

@export var levels: Array[PackedScene]

@export var current_level_index := 0



func open(id : int):
	close()
	active_level = levels[id].instantiate()

	add_child(active_level)
	
	player.position = active_level.player_spawn.position
	player.reset()

func restart_level() -> void:
	open(current_level_index)

func open_next_level() -> void:
	current_level_index += 1
	if current_level_index < levels.size():
		open(current_level_index)
	else:
		print("GAME COMPLETE")
	

func close():
	if not active_level:
		return

	active_level.queue_free()
	active_level = null
