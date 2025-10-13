extends Control
const TEXTSZENE_LAD = preload("uid://dxlggam2l1sat")
const TEXTSZENE_MIL = preload("uid://33rcpolxv4n4")
var timer=0
const TEXTSZENE_NOM = preload("uid://t5qhdnwyqylx")

func _process(delta: float) -> void:
	timer+=delta
	if timer > 20:
		get_tree().root.add_child(TEXTSZENE_NOM.instantiate())
		queue_free()


func l() -> void:
	get_tree().root.add_child(TEXTSZENE_LAD.instantiate())
	queue_free()



func mi() -> void:
	get_tree().root.add_child(TEXTSZENE_MIL.instantiate())
	queue_free()
