extends Node

## This method is supposed to emmit sounds after the emmiter is freed and should only
## be used for this specific purpose as it frees the AudioStreamPlayer afterwards
func play_and_discard(audio_stream_player : AudioStreamPlayer) -> void:
	if audio_stream_player.stream:
		audio_stream_player.reparent(self)
		audio_stream_player.play()
		await audio_stream_player.finished
	audio_stream_player.queue_free()
