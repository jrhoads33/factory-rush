# FactoryManager.gd
extends Node2D
class_name FactoryManager

@onready var tile_layer: TileMapLayer = $Level1
@onready var machine_container: Node2D = $MachineContainer

var grid: Dictionary = {}


func _ready() -> void:
	GameManager.factory_manager = self
	setup_default_machines()


func setup_default_machines() -> void:
	var machine_scene: PackedScene = preload("res://scenes/machine.tscn")
	var conveyor: MachineDefinition = preload("res://data/machines/converyer.tres")
	place_machine(Vector2i(0, 0), machine_scene, conveyor)
	place_machine(Vector2i(1, 0), machine_scene, conveyor)


func get_tile(coords: Vector2i) -> TileCellData:
	return grid.get(coords, null)


func is_occupied(coords: Vector2i) -> bool:
	return grid.has(coords) and grid[coords].machine_ref != null


func place_machine(coords: Vector2i, machine_scene: PackedScene, resource: Resource) -> bool:
	if is_occupied(coords):
		return false
	var world_pos: Vector2 = tile_layer.map_to_local(coords)
	var machine: Node2D = machine_scene.instantiate()
	machine.machine_resource = resource
	machine.position = world_pos
	machine.grid_pos = coords
	machine.setup_inventory()
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
