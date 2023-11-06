extends "res://scenes/Scene.gd"

@onready var board: Node2D = $Board
@onready var gear: Sprite2D = $Reset/Gear

func _on_reset_interact() -> void:
	var tween := create_tween()
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(gear, "rotation_degrees", 360.0, 0.2).as_relative()
	
	tween.tween_callback(board.reset)
