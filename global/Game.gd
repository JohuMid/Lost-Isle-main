extends Node

class Flags:
	signal changed
	
	var _flags := []
	
	func has(flag: String):
		return flag in _flags
	
	func add(flag: String):
		if flag in _flags:
			return
		_flags.append(flag)
		emit_signal("changed")

class Inventory:
	signal changed
	
	var active_item: Item
	
	var _items := []
	var _current_item_index := -1
		
	func get_item_count() -> int:
		return _items.size()
		
	func get_current_item() -> Item:
		if _current_item_index == -1:
			return null
		return _items[_current_item_index]
	
	func add_item(item: Item):
		if item in _items:
			return
		_items.append(item)
		_current_item_index = _items.size() - 1
		emit_signal("changed")
	
	func remove_item(item: Item):
		var index := _items.find(item)
		if index == -1:
			return
		_items.remove_at(index)
		if _current_item_index >= _items.size():
			_current_item_index = 0
		emit_signal("changed")
		
	func select_next():
		if _current_item_index == -1:
			return
		_current_item_index = (_current_item_index + 1) % _items.size()
		emit_signal("changed")
		
	func select_prev():
		if _current_item_index == -1:
			return
		_current_item_index = (_current_item_index - 1 + _items.size()) % _items.size()
		emit_signal("changed")
	
	

var flags := Flags.new()

var inventory := Inventory.new()
