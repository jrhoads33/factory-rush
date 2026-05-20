extends Node2D

@export var item_resource: Item

var id: String


func _ready() -> void:
	id = item_resource.item_id if item_resource.item_id else "metal"
