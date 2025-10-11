class_name Box
extends RigidBody2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func jumppad(force):
	apply_central_force(Vector2(0,-force))
	
