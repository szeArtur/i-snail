extends Node


const SAVE_DIRECTORY := "res://saves/%s.tres"
const SAVE_NAME := "test_save"


func _ready() -> void:
	DirAccess.make_dir_absolute(SAVE_DIRECTORY)


## This method loops over all nodes in the 'Persist' group and calls their
## 'save_data()' method. This methods return data gets stored and will
## later be given to the 'load_data()' method of the same node.
## The save and load methods are treated as black boxes
## by the save manager and can be very versitile,
## though it is highly recomended that parent nodes should call their childs
## save and load methods instead of marking children as 'persistent'.
## This insures that parent nodes are loaded befor their children.
## Nodes in the 'Persist' group must exist while loading.
func save_game() -> void:
	var save = Save.new()
	var nodes_to_save := get_tree().get_nodes_in_group("Persist")

	for node in nodes_to_save:
		assert(node.has_method("save_data"), "node \"" + node.name + "\"
				is marked to save but has no save_data() function")
		save.data[node.get_path()] = node.save_data()

	ResourceSaver.save(save, SAVE_DIRECTORY % SAVE_NAME)


## Please [param await] this method to function properly.
## The save and load methods are treated as black boxes
## by the save manager and can be very versitile,
## though it is highly recomended that parent nodes should call their childs
## save and load methods instead of marking children as 'persistent'.
## This insures that parent nodes are loaded befor their children.
func load_game() -> void:
	var save : Save
	var load_path := SAVE_DIRECTORY % SAVE_NAME

	if ResourceLoader.exists(load_path):
		save = ResourceLoader.load(load_path).duplicate()

	for key in save.data:
		# Nodes in the 'Persist' group must exist while loading.
		assert(get_node(key), "could not find node \"" + str(key))
		var node = get_node(key)
		
		assert(node.has_method("load_data"), "node \"" + node.name + "\"
				is marked to load but has no load_data() function")
		await node.load_data(save.data[key])
