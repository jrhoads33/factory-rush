# FactoryManager.gd
extends Node2D
class_name FactoryManager

@onready var tile_layer: TileMapLayer = $Level1
@onready var machine_container: Node2D = $MachineContainer

var grid: Dictionary = {}  # Vector2i → TileData

func _ready() -> void:
	GameManager.factory_manager = self

func get_tile(coords: Vector2i) -> TileCellData:
	return grid.get(coords, null)

func is_occupied(coords: Vector2i) -> bool:
	return grid.has(coords) and grid[coords].machine_ref != null

func place_machine(coords: Vector2i, machine_scene: PackedScene, resource: Resource) -> bool:
	if is_occupied(coords):
		return false
	var world_pos = tile_layer.map_to_local(coords)
	var machine = machine_scene.instantiate()
	machine.machine_resource = resource
	machine.position = world_pos
	machine.grid_pos = coords
	machine_container.add_child(machine)

	if not grid.has(coords):
		grid[coords] = TileCellData.new()
	grid[coords].machine_ref = machine
	grid[coords].is_occupied = true
	return true

func remove_machine(coords: Vector2i) -> void:
	if not is_occupied(coords):
		return
	grid[coords].machine_ref.queue_free()
	grid[coords].machine_ref = null
	grid[coords].is_occupied = false
	
func _exit_tree() -> void:
	GameManager.factory_manager = null
