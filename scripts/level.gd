class_name Level
extends Node2D


@export var collectable_manager: CollectableManager
@export var spawn_point_manager: SpawnPointManager
@export var enemy_manager: EnemyManager


func _ready() -> void:
	assert(collectable_manager, name + " has no CollectableManager")
	assert(spawn_point_manager, name + " has no SpawnPointManager")
	assert(enemy_manager, name + " has no EnemyManager")

	collectable_manager.all_collectables_collected.connect(all_collectables_collected)


func get_spawn_points(spawn_id: String = "") -> Array[SpawnPoint]:
	return spawn_point_manager.get_by_id(spawn_id)


func all_collectables_collected():
	EventBus.level_completed.emit()
