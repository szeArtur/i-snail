class_name ParticleEmitter
extends Area2D


@export var particle_scene: PackedScene
## amount of particles per second
@export var amount: int = 100
@export var emitting: bool = true

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _process(delta: float) -> void:
	if not emitting:
		return
	
	# TODO make this not suck
	for i in range(amount):
		if randf() < delta:
			emit()
	
func emit() -> void:
	assert(particle_scene, "missing particle scene")
	var particle = particle_scene.instantiate()
	
	var rect := collision_shape_2d.shape.get_rect()
	var x := randf_range(rect.position.x, rect.position.x+rect.size.x)
	var y := randf_range(rect.position.y, rect.position.y+rect.size.y)
	
	add_child(particle)
	particle.position = Vector2(x,y) 
