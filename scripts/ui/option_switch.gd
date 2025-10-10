class_name OptionSwitch
extends Button


@export var option_name: StringName
@export var option_label: String

@onready var label: Label = $MarginContainer/HBoxContainer/Label
@onready var switch: CheckButton = $MarginContainer/HBoxContainer/Switch


func _ready() -> void:
	label.text = (option_label if option_label else (option_name as String)) + ":"

	assert(OptionsManager.options.get(option_name) is bool)
	button_pressed = OptionsManager.options.get(option_name)
	switch.button_pressed = OptionsManager.options.get(option_name)


func _update(option_on):
	button_pressed = option_on
	switch.button_pressed = option_on

	OptionsManager.options.set(option_name, option_on)
	OptionsManager.options.apply()
