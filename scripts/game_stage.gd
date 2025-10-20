class_name GameStage
extends Node2D


@onready var player: Player = $"../Player"

@export var levels: Array[PackedScene]
@export var active_scene_index := 0

var active_scene: GameLevel


func open(id : int):
	close()
	active_scene = levels[id].instantiate()

	add_child(active_scene)
	
	if active_scene is GameLevel:
		player.position = active_scene.player_spawn.position
		player.reset()


func restart() -> void:
	open(active_scene_index)


func open_next_level() -> void:
	active_scene_index += 1
	if active_scene_index < levels.size():
		open(active_scene_index)
	else:
		print("GAME COMPLETE")
	

func close():
	if not active_scene:
		return

	active_scene.queue_free()
	active_scene = null
