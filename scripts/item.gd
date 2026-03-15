extends Node2D

@export var item_definition : ItemDefinition

func _ready() -> void:
	if item_definition.texture:
		$Sprite2D.texture = item_definition.texture


func _process(delta: float) -> void:
	pass
