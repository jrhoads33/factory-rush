# item.gd
class_name Item
extends Resource

@export var item_id: String = "stone"
@export var display_name: String = "stone"
@export var quantity: int = 0
@export var max_stack: int = 99
@export var metadata: Dictionary = {}
