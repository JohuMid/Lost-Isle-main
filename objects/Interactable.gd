@tool
extends Area2D
class_name Interactable

signal interact

@export var allow_item := false
@export var texture: Texture:
	set=set_texture

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if not event.is_action_pressed("interact"):
		return
	if not allow_item and Game.inventory.active_item:
		return
	_interact()
	
func _interact():
	emit_signal("interact")

func set_texture(v :Texture):
	texture = v
	# 遍历子节点
	for node in get_children():
		# 不是通过编辑器添加
		if node.owner == null:
			node.queue_free()
			
	if texture == null:
		return
	var sprite:=Sprite2D.new()
	sprite.texture = texture
	add_child(sprite)
	
	var rect := RectangleShape2D.new()
	rect.extents = v.get_size() / 2
	
	var collider := CollisionShape2D.new()
	collider.shape = rect
	add_child(collider)
	
	
