class_name JumpPad
extends Area2D
@onready var anime_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var force:= 5000.0
func activate():
	anime_sprite.play()




func _on_body_entered(body: Node2D) -> void:
	print("ja")
	if body is Box:
		print("baba")
		body.jumppad(force)
