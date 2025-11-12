class_name GameLevel
extends GameScene


@export var player_spawn: Node2D
@export var salt_rain_emitter: ParticleEmitter
@export_range(0.1, 10, 0.1, "suffix:s") var salt_rain_length: float = 4


func _ready() -> void:
	EventBus.drop_shell.connect(drop_shell)
	EventBus.player_detected.connect(salt_rain)


func drop_shell(shell: Shell) -> void:
	shell.reparent(self)

func salt_rain() -> void:
	salt_rain_emitter.emitting = true
	await get_tree().create_timer(salt_rain_length).timeout
	salt_rain_emitter.emitting = false
