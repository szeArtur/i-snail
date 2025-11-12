## Abstract base class of all abilities. Provides [member agent] variable.
@abstract class_name Ability
extends Resource


var agent: Agent


@abstract func update(_delta: float, input_direction: float = 0) -> void
@abstract func activate() -> void
