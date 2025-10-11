class_name Level
extends Node2D


@export var spawn_point_manager: SpawnPointManager
@export var enemy_manager: EnemyManager
@export var player_spawn: SpawnPoint


func _ready() -> void:
	assert(spawn_point_manager, name + " has no SpawnPointManager")
	assert(enemy_manager, name + " has no EnemyManager")

	EventBus.connect("drop_item", spawn_collectable)


func get_spawn_points(spawn_id: String = "") -> Array[SpawnPoint]:
	return spawn_point_manager.get_by_id(spawn_id)


func all_collectables_collected():
	EventBus.level_completed.emit()

func spawn_collectable(item: Item, at: Vector2, toward: Vector2) -> void:
	var collectable: Collectable = load("res://scenes/collectable.tscn").instantiate()
	collectable.item = item
	collectable.position = at
	collectable.linear_velocity = toward
	add_child(collectable)
