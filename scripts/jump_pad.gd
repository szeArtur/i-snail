class_name JumpPad
extends Area2D


@onready var anime_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var force := 800.0


func _on_body_entered(body: Node2D) -> void:
	if body is Agent:
		body.velocity.y = -force
	if body is RigidBody2D:
		body.set_axis_velocity(Vector2.UP * force)
	
	anime_sprite.play()
	audio_stream_player_2d.play()
