extends Node

var factory_manager: FactoryManager = null

enum MachineType {CONVEYER, HOPPER}




func place_machine(coords: Vector2i, resource: MachineDefinition) -> bool:
	if factory_manager == null:
		return false
	return factory_manager.place_machine(coords, resource)


func attempt_rotate_machine(coords: Vector2i) -> bool:
	if factory_manager == null:
		return false
	var tile: TileCellData = factory_manager.get_tile(coords)
	if tile == null:
		return false
	tile.machine_ref.rotate_machine(90)
	return true


func attempt_disable_machine(coords: Vector2i) -> bool:
	if factory_manager == null:
		return false
	var tile: TileCellData = factory_manager.get_tile(coords)
	if tile == null:
		return false
	tile.machine_ref.toggle_machine()
	return true
