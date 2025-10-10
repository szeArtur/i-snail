class_name SpawnPoint
extends Marker2D


@export var spawn_id: StringName = "default"
@export var scene: PackedScene


func spawn(at_parent: Node = null) -> Node2D:
	if not scene:
		return null

	var node := scene.instantiate()
	assert(node is Node2D)
	if at_parent:
		at_parent.add_child(node)
	else:
		get_parent().add_child(node)
	node.global_position = global_position

	return node
