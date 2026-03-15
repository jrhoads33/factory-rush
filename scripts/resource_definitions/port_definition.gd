class_name PortDefinition
extends Resource

enum PortType { INPUT, OUTPUT }

@export var id: String = ""
@export var port_type: PortType = PortType.INPUT
@export var direction: Vector2i = Vector2i.RIGHT
