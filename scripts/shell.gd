class_name Shell
extends RigidBody2D

@export var ability: Ability
@export var is_collectable := true

func collect(agent: Agent) -> void:
	ability.agent = agent
	reparent(agent.shell_origin, true)
	process_mode = Node.PROCESS_MODE_DISABLED
	position = Vector2.ZERO
	rotation = 0


func drop(impulse: Vector2) -> void:
	process_mode = Node.PROCESS_MODE_INHERIT
	EventBus.drop_shell.emit(self)
	apply_central_impulse(impulse)
	is_collectable = false
	await get_tree().create_timer(1).timeout
	is_collectable = true
