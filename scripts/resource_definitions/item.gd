# item.gd
class_name Item_resource
extends Resource

@export var item_id: String = ""
@export var display_name: String = ""
@export var quantity: int = 0
@export var max_stack: int = 99
@export var metadata: Dictionary = {}
