class_name MachineDefinition
extends Resource

@export var id: String = ""
@export var display_name: String = ""
@export var texture: Texture2D = null
@export var size: Vector2i = Vector2i(1, 1)
@export var process_time: float = 1.0
@export var recipe_category: String = ""
@export var ports: Array[PortDefinition] = []
@export var location: Vector2i = Vector2i(0, 0)
@export var orientation: int = 0
@export var process_ticks: int = 1
@export var generation_ticks: int = 5
@export var inventory_slots: int = 10
