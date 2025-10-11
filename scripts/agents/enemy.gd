class_name Enemy
extends Agent

@export var jumpforce := 10.0
@export var start_links:= true
var movement_direction
func _ready() -> void:
	super._ready()
	movement_controller = MovementController.new(self)
	if start_links:
		movement_direction = -1
	else:
		movement_direction = 1
func _physics_process(delta: float) -> void:
	movement_controller.move(delta, movement_direction, true)
func _on_hitbox_entered(body: CollisionObject2D) -> void:
	if body is TurnaroundEnemy:
		movement_direction *= -1
