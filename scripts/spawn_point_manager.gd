class_name SpawnPointManager
extends Node


@onready var spawn_points := get_children().filter(func(node): return node is SpawnPoint)


func get_by_id(spawn_id: String = "") -> Array:
	if not spawn_id:
		return spawn_points
	else:
		return spawn_points.filter(func(spawn_point): return spawn_point.spawn_id == spawn_id)
