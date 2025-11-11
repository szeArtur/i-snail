extends RigidBody2D

func _ready() -> void:
	$Sprite2D.texture = $Sprite2D.texture.duplicate()
	rotation = randf() * TAU

func _on_timer_timeout() -> void:
	queue_free()
