class_name Collectable
extends RigidBody2D


signal collected

@export var item: Item
@onready var sprite: Sprite2D = $Sprite
@onready var audio: AudioStreamPlayer = $Audio


func _ready() -> void:
	update_display()


func update_display() -> void:
	sprite.texture = item.sprite


func pickup() -> void:
	collected.emit(self)
	audio.set_stream(item.pickup_sound)
	AudioManager.play_and_discard(audio)
	queue_free()
