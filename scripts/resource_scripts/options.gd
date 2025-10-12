class_name Options extends Resource


@export_group("Audio")
@export_range(0, 1, 0.01) var master_volume: float = 0.5
@export_range(0, 1, 0.01) var music_volume: float = 0.5
@export_range(0, 1, 0.01) var effects_volume: float = 0.5
@export_range(0, 1, 0.01) var ui_volume: float = 0.5

@export_group("Controls")
@export var keymap: Dictionary[StringName, InputEvent]


func apply():
	AudioServer.set_bus_volume_db(
			AudioServer.get_bus_index(&"Master"), linear_to_db(master_volume))
	AudioServer.set_bus_volume_db(
			AudioServer.get_bus_index(&"Music"), linear_to_db(music_volume))
	AudioServer.set_bus_volume_db(
			AudioServer.get_bus_index(&"Effects"), linear_to_db(effects_volume))
	AudioServer.set_bus_volume_db(
			AudioServer.get_bus_index(&"UI"), linear_to_db(ui_volume))


	for key in keymap:
		if InputMap.has_action(key):
			InputMap.action_erase_events(key)
		else:
			InputMap.add_action(key)
		InputMap.action_add_event(key, keymap[key])
