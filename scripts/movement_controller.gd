class_name MovementController
extends Node


@export var max_speed := 100.0
@export var acceleration_time := 0.1

var agent: Agent


func move_and_slide_toward(to: Vector2, delta: float) -> void:
	var velocity := agent.velocity
	velocity = velocity.move_toward(
			to.normalized() * max_speed,
			(1.0 / acceleration_time) * delta * max_speed
			)

	# extra friction on turnaround
	if to.y and sign(to.y) != sign(velocity.y):
		velocity.y *= 0.75
	if to.x and sign(to.x) != sign(velocity.x):
		velocity.x *= 0.75

	agent.velocity = velocity
	agent.move_and_slide()
