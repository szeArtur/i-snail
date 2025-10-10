extends Node


var options: Options = preload("res://resources/default_options.tres")


func _ready() -> void:
	options.apply()


func load_data(data : Options):
	options = data.duplicate()
	options.apply()


func save_data() -> Options:
	return options
