extends Label
@onready var TextBox: Label = $"../TextBox"
func _ready() -> void:
	text=TextBox.alles_text.messages[0].name
	match TextBox.alles_text.messages[0].position:
		0:
			horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
		1:
			horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		2:
			horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT

func _process(_delta: float) -> void:
	if TextBox.text_number <len(TextBox.alles_text.messages):
		text=TextBox.alles_text.messages[TextBox.text_number].name
		match TextBox.alles_text.messages[TextBox.text_number].position:
			0:
				horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
			1:
				horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			2:
				horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
