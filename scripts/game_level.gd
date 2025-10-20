class_name GameLevel
extends GameScene

@export var player_spawn: Node2D


func _ready() -> void:
	EventBus.drop_item.connect(spawn_item)


func spawn_item(shell: Item, at := Vector2.ZERO, toward := Vector2.ZERO) -> void:
	var collectable: Collectable = load("res://scenes/assets/collectable.tscn").instantiate()
	collectable.item = shell
	collectable.position = at
	collectable.apply_central_impulse(toward)
	
	add_child(collectable)
