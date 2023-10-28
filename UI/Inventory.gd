extends VBoxContainer

@onready var label: Label = $Label
@onready var prev: TextureButton = $ItemBar/Prev
@onready var prop: Sprite2D = $ItemBar/Use/Prop
@onready var hand: Sprite2D = $ItemBar/Use/Hand
@onready var next: TextureButton = $ItemBar/Next

func _ready() -> void:
	_update_ui()

func  _update_ui():
	var count := Game.inventory.get_item_count()
	prev.disabled = count < 2
	next.disabled = count < 2
	
	
