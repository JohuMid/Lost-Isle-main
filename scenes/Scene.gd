extends Sprite2D
class_name Scene

@export_file("*.mp3") var music_override := ""

func _ready():
	var tween := create_tween()
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self,"scale",Vector2.ONE,0.3).from(Vector2.ONE * 1.05)
