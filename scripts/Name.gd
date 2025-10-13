extends Label
@onready var TextBox: Label = $"../TextBox"
@onready var last_text_number=TextBox.text_number

func _ready() -> void:
	custom_minimum_size.x = 250
	text=TextBox.alles_text.messages[0].name
	match TextBox.alles_text.messages[0].position:
		0:
			horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
		1:
			horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		2:
			horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	match TextBox.alles_text.messages[0].position:
		0:
			size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
		1:
			size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		2:
			size_flags_horizontal = Control.SIZE_SHRINK_END
func _process(_delta: float) -> void:
	if TextBox.text_number != last_text_number:
		_update_from_textbox()
		
func _update_from_textbox() -> void:
	last_text_number+=1
	if TextBox.text_number <len(TextBox.alles_text.messages):
		text=TextBox.alles_text.messages[TextBox.text_number].name
		match TextBox.alles_text.messages[TextBox.text_number].position:
			0:
				horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
			1:
				horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			2:
				horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		match TextBox.alles_text.messages[TextBox.text_number].position:
			0:
				size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
			1:
				size_flags_horizontal = Control.SIZE_SHRINK_CENTER
			2:
				size_flags_horizontal = Control.SIZE_SHRINK_END
