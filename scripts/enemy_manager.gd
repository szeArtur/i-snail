class_name EnemyManager
extends Node


@onready var enemies := get_children().filter(func(node): return node is Enemy)
