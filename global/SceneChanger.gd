extends CanvasLayer
@onready var color_rect = $ColorRect

func change_scene(path: String):
	var tween := create_tween()
	# 展示rect
	tween.tween_callback(color_rect.show)
	# 动画a通道设置1设置0.2秒
	tween.tween_property(color_rect,"color:a",1.0,0.2)
	# 切换场景
	tween.tween_callback(get_tree().change_scene_to_file.bind(path))
	# 动画a通道设置0设置0.2秒
	tween.tween_property(color_rect,"color:a",0.0,0.2)
	# 隐藏rect
	tween.tween_callback(color_rect.hide)
	
