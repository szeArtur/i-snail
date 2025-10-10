class_name OptionKeymap
extends Button


const input_action_names: Dictionary[StringName, String] = {
	&"move_left": "Move Left",
	&"move_right": "Move Right",
	&"drop_item": "Drop Item",
	&"slime": "Toggle Slime-mode",
}

@export var action_name: StringName
@export var action_label: String

var key := InputEventKey.new()

@onready var label: Label = $MarginContainer/HBoxContainer/Label
@onready var label_input: Label = $MarginContainer/HBoxContainer/LabelInput


func _ready() -> void:
	if input_action_names.has(action_name):
		label.text = input_action_names[action_name] + ":"
	else:
		label.text = (action_name as String) + ":"

	assert(OptionsManager.options.keymap.has(action_name))
	key = OptionsManager.options.keymap[action_name]
	update()


func update(_val = null) -> void:
	if button_pressed:
		label_input.text = "..."
	else:
		label_input.text = key.as_text().trim_suffix(" (Physical)")


func _input(event: InputEvent) -> void:
	if not button_pressed:
		return
	if not (event is InputEventKey or event is InputEventMouseButton):
		return

	if event is InputEventMouseButton:
		event.double_click = false
	key = event

	OptionsManager.options.keymap[action_name] = key
	OptionsManager.options.apply()

	update()
	accept_event()
	button_pressed = false
