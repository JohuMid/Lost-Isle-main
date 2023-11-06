extends CanvasLayer

signal game_entered
signal game_exited

@onready var color_rect = $ColorRect
func _ready() -> void:
	_on_scene_changed(null,get_tree().current_scene)

func change_scene(path: String):
	var tween := create_tween()
	# 展示rect
	tween.tween_callback(color_rect.show)
	# 动画a通道设置1设置0.2秒
	tween.tween_property(color_rect,"color:a",1.0,0.2)
	# 切换场景
	tween.tween_callback(_change_scene.bind(path))
	# 动画a通道设置0设置0.2秒
	tween.tween_property(color_rect,"color:a",0.0,0.2)
	# 隐藏rect
	tween.tween_callback(color_rect.hide)

func _change_scene(path: String):
	var old_scene := get_tree().current_scene
	var new_scene := load(path).instantiate() as Node
	
	var root := get_tree().root
	root.remove_child(old_scene)
	root.add_child(new_scene)
	get_tree().current_scene = new_scene
	_on_scene_changed(old_scene, new_scene)
	
	
func _on_scene_changed(old_scene: Node, new_scene:Node):
	var was_in_game := old_scene is Scene
	var is_in_game := new_scene is Scene
	if was_in_game != is_in_game:
		if is_in_game:
			emit_signal("game_entered")
		else:
			emit_signal("game_exited")
	
	var music := "res://assets/Music/PaperWings.mp3"
	
	if is_in_game and new_scene.music_override:
		music = new_scene.music_override
		
	SoundMananger.play_music(music)
#	old_scene.queue_free()

