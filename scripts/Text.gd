extends Label
@export var alles_text: Dialoque 
@onready var v_box_container: VBoxContainer = $".."
@export var time_betwen_cahr :=0.1
var time_already=0
var text_number = 0
var time_till_next_box =0
@export var max_time_till_next_box: int =1
func _ready() -> void:
	visible_characters=0
	text= alles_text.messages[0].text
	match alles_text.messages[0].position:
		0:
			horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
		1:
			horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		2:
			horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT

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
				1:
					horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
				2:
					horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT

			
			time_till_next_box=0
func _process(delta: float) -> void:
	time_already+=delta
	time_till_next_box+=delta
	if time_already >= time_betwen_cahr:
		visible_characters+=1
	if visible_ratio > 1:
		pass
		#visible_ratio=1
	
