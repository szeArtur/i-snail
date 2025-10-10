extends VBoxContainer
# loosely adapted from https://www.youtube.com/watch?v=ZDPM45cHHlI


@export var option_keymap_scene: PackedScene


func _ready() -> void:
	InputMap.load_from_project_settings()
	for item in get_children():
		item.queue_free()

	for action in OptionsManager.options.keymap:
		var option_keymap_button: OptionKeymap = option_keymap_scene.instantiate()

		option_keymap_button.action_name = action

		add_child(option_keymap_button)
