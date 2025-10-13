class_name JumpPad
extends Area2D
@onready var anime_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var force:= 5000.0
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func activate():
	anime_sprite.play()
	audio_stream_player_2d.play()

func _on_body_entered(body: Node2D) -> void:
	body.jumppad(force)
	activate()
