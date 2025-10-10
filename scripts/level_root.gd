class_name LevelRoot
extends Node2D


var active_level: Level
var active_level_name: StringName

@export var levels: Dictionary[StringName, PackedScene]


func open(id : StringName):
	if not levels.has(id):
		push_warning("id %s not found" % id)
		return

	close()
	active_level_name = id
	active_level = levels[id].instantiate()

	add_child(active_level)


func close():
	if not active_level:
		return

	active_level.queue_free()
	active_level = null
