extends Node

var factory_manager: FactoryManager = null

func place_machine(coords: Vector2i, scene: PackedScene, resource: MachineDefinition) -> bool:
	if factory_manager == null:
		return false
	return factory_manager.place_machine(coords, scene, resource)
