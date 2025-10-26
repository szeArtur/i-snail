class_name Enemy
extends Agent

@export var stopped := false
@export var facing_right := true

func _physics_process(delta: float) -> void:
	if not stopped:
		move_and_stick(delta, 1 if facing_right else -1)
