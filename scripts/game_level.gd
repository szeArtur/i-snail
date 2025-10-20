class_name GameLevel
extends GameScene

@export var player_spawn: Node2D


func _ready() -> void:
	EventBus.drop_item.connect(spawn_item)


func spawn_item(collectable: Collectable) -> void:
	add_child(collectable)
