class_name SpawnPointManager
extends Node


@onready var spawn_points := get_children().filter(func(node): return node is SpawnPoint)


func _ready() -> void:
	spawn_all($"../EnemyManager")


func get_by_id(spawn_id: String = "") -> Array:
	if not spawn_id:
		return spawn_points
	else:
		return spawn_points.filter(func(spawn_point): return spawn_point.spawn_id == spawn_id)


func spawn_all(at_parent: Node = null) -> void:
	for spawn_point in spawn_points:
		spawn_point.spawn(at_parent)
