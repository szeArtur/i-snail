class_name JumpPad
extends Area2D
@onready var anime_sprite: AnimatedSprite2D = $AnimatedSprite2D

func activate():
	anime_sprite.play()
