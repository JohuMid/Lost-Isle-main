extends Node2D
class_name FlagSwitch

@export var flag: String

var defaule_node: Node2D # flag不存在默认显示节点
var switch_node: Node2D # flag存在显示的节点

func _ready() -> void:
	var count := get_child_count()
	if count > 0:
		defaule_node = get_child(0)
	if count > 1:
		switch_node = get_child(1)
	
	Game.flags.connect("changed", _update_nodes)
	_update_nodes()

func _update_nodes():
	var exists := Game.flags.has(flag)
	if defaule_node:
		defaule_node.visible = not exists
		
	if switch_node:
		switch_node.visible = exists
	
