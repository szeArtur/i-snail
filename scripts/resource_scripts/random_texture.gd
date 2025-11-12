class_name RandomTexture
extends Texture2D


@export var textures: Array[Texture2D]

var selected_texture: Texture2D:
	get():
		if not selected_texture:
			assert(textures.size() > 0, "No textures assigned to RandomTexture2D!")
			selected_texture = textures[randi() % textures.size()]
		return selected_texture


func _draw(to_canvas_item: RID, pos: Vector2, modulate: Color, transpose: bool) -> void:
	selected_texture.draw(to_canvas_item, pos, modulate, transpose)

func _draw_rect(to_canvas_item: RID, rect: Rect2, tile: bool, modulate: Color, transpose: bool) -> void:
	selected_texture.draw_rect(to_canvas_item, rect, tile, modulate, transpose)

func _draw_rect_region(to_canvas_item: RID, rect: Rect2, src_rect: Rect2, modulate: Color, transpose: bool, clip_uv: bool) -> void:
	selected_texture.draw_rect_region(to_canvas_item, rect, src_rect, modulate, transpose, clip_uv)

func _get_height() -> int:
	return selected_texture.get_width()

func _get_width() -> int:
	return selected_texture.get_width()

func _has_alpha() -> bool:
	return selected_texture.has_alpha()
