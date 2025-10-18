class_name GrabPoint
extends Marker2D


@onready var label: Label = $Label


func _ready() -> void:
	update(false)


func update(active := false) -> void:
	label.text = "grab (" + InputMap.get_action_description("interact") + ")"
	visible = active
