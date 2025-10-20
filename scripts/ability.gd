@abstract class_name Ability
extends Resource


@export var name: String
var agent: Agent


@abstract func update(_delta: float, input_direction: float = 0) -> void
@abstract func activate() -> void
