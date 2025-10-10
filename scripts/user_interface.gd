class_name UserInterface
extends CanvasLayer


@export var menus : Dictionary[StringName, PackedScene]

var open_menus : Dictionary[StringName, Menu]


func open(id : String):
	if not menus.has(id):
		return

	open_menus[id] = menus[id].instantiate()
	add_child(open_menus[id])


func close(id : String = ""):
	if not id: for key in open_menus:
		close(key)

	if not open_menus.has(id):
		return

	open_menus[id].queue_free()
	open_menus.erase(id)
