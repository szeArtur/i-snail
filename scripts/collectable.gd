class_name Collectable
extends CollisionObject2D


signal collected

@export var item: Item
@export var amount: int = 1

@onready var sprite: Sprite2D = $Sprite
@onready var label: Label = $Label
@onready var audio: AudioStreamPlayer = $Audio


func _ready() -> void:
	update_display()


func update_display() -> void:
	sprite.texture = item.sprite
	label.text = str(amount)


func _on_body_entered(body : Node2D) -> void:
	if body is Player:
		collected.emit(self)
		audio.set_stream(item.pickup_sound)
		AudioManager.play_and_discard(audio)
		queue_free()
