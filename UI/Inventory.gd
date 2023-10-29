extends VBoxContainer

var _hand_outro: Tween
var _label_outro: Tween

@onready var label: Label = $Label
@onready var prev: TextureButton = $ItemBar/Prev
@onready var prop: Sprite2D = $ItemBar/Use/Prop
@onready var hand: Sprite2D = $ItemBar/Use/Hand
@onready var next: TextureButton = $ItemBar/Next
@onready var timer = $Label/Timer

func _ready() -> void:
	hand.hide()
	hand.modulate.a = 0.0
	
	label.hide()
	label.modulate.a = 0.0
	
	Game.inventory.connect("changed",_update_ui)
	_update_ui(true)

func _input(event):
	if event.is_action_pressed("interact") and Game.inventory.active_item:
		# 设置当前选择道具为null，当前帧的末尾，将给定属性 property 的值分配为 value
		Game.inventory.set_deferred("active_item", null)
		
		
		_hand_outro = create_tween()
		_hand_outro.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE).set_parallel()
		_hand_outro.tween_property(hand, "scale", Vector2.ONE * 3, 0.15)
		_hand_outro.tween_property(hand, "modulate:a", 0.0, 0.15)
		_hand_outro.chain().tween_callback(hand.hide)

func  _update_ui(is_init := false):
	var count := Game.inventory.get_item_count()
	prev.disabled = count < 2
	next.disabled = count < 2
	visible = count > 0
	
	var item := Game.inventory.get_current_item()
	
	if not item:
		return
		
	label.text = item.description
	prop.texture = item.prop_texture
	if is_init:
		return
	
	var tween := create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tween.tween_property(prop, "scale", Vector2.ONE, 0.15).from(Vector2.ZERO)
	
	_show_label()
	
func _show_label():
	if _label_outro and _label_outro.is_valid():
		_label_outro.kill()
		_label_outro = null
		
	label.show()
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(label, "modulate:a", 1.0, 0.2)
	tween.tween_callback(timer.start)
	
	
func _on_prev_pressed():
	Game.inventory.select_prev()


func _on_next_pressed():
	Game.inventory.select_next()


func _on_use_pressed():
	Game.inventory.active_item = Game.inventory.get_current_item()
	if _hand_outro and _hand_outro.is_valid():
		_hand_outro.kill()
		_hand_outro = null
		
	hand.show()
	
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK).set_parallel()
	tween.tween_property(hand, "scale", Vector2.ONE, 0.15).from(Vector2.ZERO)
	tween.tween_property(hand,"modulate:a", 1.0, 0.15)


func _on_timer_timeout():
	_label_outro = create_tween()
	_label_outro.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	_label_outro.tween_property(label,"modulate:a", 0.0, 0.2)
	_label_outro.tween_callback(label.hide)
	
	
