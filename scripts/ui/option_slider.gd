class_name OptionSlider
extends Button


@export var option_name: StringName
@export var option_label: String

@onready var label: Label = $MarginContainer/HBoxContainer/Label
@onready var slider: HSlider = $MarginContainer/HBoxContainer/Slider


func _ready() -> void:
	label.text = (option_label if option_label else (option_name as String)) + ":"

	assert(OptionsManager.options.get(option_name) is float)
	button_pressed = OptionsManager.options.get(option_name)
	slider.value = OptionsManager.options.get(option_name)


func _update(_val) -> void:
	OptionsManager.options.set(option_name, slider.value)
	OptionsManager.options.apply()
