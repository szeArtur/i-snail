extends AudioStreamPlayer

func _on_timer_timeout() -> void:
	play()


func _on_finished() -> void:
	$AudioStreamPlayer2D.playing = true
