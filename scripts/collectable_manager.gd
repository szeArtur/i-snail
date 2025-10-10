class_name CollectableManager
extends Node


signal all_collectables_collected

@onready var collectables := get_children().filter(func(node): return node is Collectable)


func _ready() -> void:
	for node: Collectable in collectables:
		node.collected.connect(on_collected)


func on_collected(sender : Collectable):
	collectables.erase(sender)
	if collectables.is_empty():
		all_collectables_collected.emit()
