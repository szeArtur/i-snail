extends Label
@export var alles_text: Dialoque 
@onready var v_box_container: VBoxContainer = $".."
@export var time_betwen_cahr :=0.1
@onready var left: Sprite2D = $"../../../Left"
@onready var mid: Sprite2D = $"../../../Mid"
@onready var right: Sprite2D = $"../../../Right"
var time_already=0
var text_number = 0
var time_till_next_box =0
@export var max_time_till_next_box: int =1
func _ready() -> void:
	autowrap_mode = TextServer.AUTOWRAP_WORD
	custom_minimum_size.x = 500
	#set_clip_text(true)  # optional, falls du lieber abschneiden willst statt umbrechen
	visible_characters=0
	text= alles_text.messages[0].text
	
	match alles_text.messages[0].position:
		0:
			horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
			left.set_modulate(Color(1, 1, 1, 1.0))
			mid.set_modulate(Color(0.54, 0.54, 0.54, 1.0))
			right.set_modulate(Color(0.54, 0.54, 0.54, 1.0))
		1:
			horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			left.set_modulate(Color(0.54, 0.54, 0.54, 1.0))
			mid.set_modulate(Color(1, 1, 1, 1.0))
			right.set_modulate(Color(0.54, 0.54, 0.54, 1.0))
		2:
			horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
			left.set_modulate(Color(0.54, 0.54, 0.54, 1.0))
			mid.set_modulate(Color(0.54, 0.54, 0.54, 1.0))
			right.set_modulate(Color(1, 1, 1, 1.0))
	match alles_text.messages[0].position:
		0:
			size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
		1:
			size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		2:
			size_flags_horizontal = Control.SIZE_SHRINK_END
	#v_box_container.set_h_size_flags(alles_text.messages[0].position)


func _unhandled_input(_event: InputEvent) -> void:

	if text_number <len(alles_text.messages)-1 and time_till_next_box >max_time_till_next_box:
		if visible_ratio >= 1:
			visible_ratio = 0
			text_number+=1
			text= alles_text.messages[text_number].text
			print(text_number)
			print(alles_text.messages[text_number].position)
			
			match alles_text.messages[text_number].position:
				0:
					horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
					left.set_modulate(Color(1, 1, 1, 1.0))
					mid.set_modulate(Color(0.54, 0.54, 0.54, 1.0))
					right.set_modulate(Color(0.54, 0.54, 0.54, 1.0))
				1:
					horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
					left.set_modulate(Color(0.54, 0.54, 0.54, 1.0))
					mid.set_modulate(Color(1, 1, 1, 1.0))
					right.set_modulate(Color(0.54, 0.54, 0.54, 1.0))
				2:
					horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
					left.set_modulate(Color(0.54, 0.54, 0.54, 1.0))
					mid.set_modulate(Color(0.54, 0.54, 0.54, 1.0))
					right.set_modulate(Color(1, 1, 1, 1.0))
			match alles_text.messages[text_number].position:
				0:
					size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
				1:
					size_flags_horizontal = Control.SIZE_SHRINK_CENTER
				2:
					size_flags_horizontal = Control.SIZE_SHRINK_END
			queue_redraw()
			time_till_next_box=0
func _process(delta: float) -> void:
	time_already+=delta
	time_till_next_box+=delta
	if time_already >= time_betwen_cahr:
		visible_characters+=1
	if visible_ratio > 1:
		pass
		#visible_ratio=1
	
