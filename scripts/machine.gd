extends Node2D

@export var machine_resource : MachineDefinition
var grid_pos : Vector2i
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.texture = machine_resource.texture if machine_resource.texture else $Sprite2D.texture
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
