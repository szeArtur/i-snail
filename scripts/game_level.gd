class_name GameLevel
extends GameScene


@export var player_spawn: Node2D


func _ready() -> void:
	EventBus.drop_shell.connect(drop_shell)


func drop_shell(shell: Shell) -> void:
	shell.reparent(self)
