class_name GameLevel
extends GameScene


@export var player_spawn: Node2D
@export var salt_rain_emitter: ParticleEmitter


func _ready() -> void:
	EventBus.drop_shell.connect(drop_shell)
	EventBus.player_detected.connect(salt_rain)


func drop_shell(shell: Shell) -> void:
	shell.reparent(self)

func salt_rain() -> void:
	salt_rain_emitter.emitting = true
	await get_tree().create_timer(4).timeout
	salt_rain_emitter.emitting = false
