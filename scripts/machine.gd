extends Node2D

@export var machine_resource: MachineDefinition

var grid_pos: Vector2i
var inventory_label: Label
var inventory_slots: int = 1
var inventory: Array = []
var generation_resource: Resource = preload("res://scripts/resource_definitions/stone_item.tres")
var active: bool = true
var port_dir: Vector2i = Vector2i(1, 0)
var process_ticks: int = 0
var generation_ticks: int = 0


func _ready() -> void:
	$Sprite2D.texture = machine_resource.texture if machine_resource.texture else $Sprite2D.texture
	setup_inventory()
	TickManager.tick.connect(_on_tick)


func setup_inventory() -> void:
	inventory_slots = machine_resource.inventory_slots
	inventory.resize(inventory_slots)
	inventory_label = $InventoryLabel
	update_inv_label()


func _on_tick() -> void:
	if not active:
		return
	update_tick_counters()
	if process_ticks >= machine_resource.process_ticks:
		process_ticks = 0
		var target_machine: TileCellData = GameManager.factory_manager.get_tile(grid_pos + port_dir)
		attempt_inv_transfer(target_machine)
	if generation_ticks >= machine_resource.generation_ticks:
		generation_ticks = 0
		if null in inventory:
			generate_resource()


func update_tick_counters() -> void:
	process_ticks += 1
	generation_ticks += 1


func attempt_inv_transfer(target_node: TileCellData) -> bool:
	if target_node == null or inventory[0] == null:
		return false
	var success: bool = target_node.machine_ref.receive_item(inventory[0])
	print("inv transfer {0}".format([success]))
	if success:
		inventory[0] = null
		shift_inventory()
		update_inv_label()
	return success


func shift_inventory() -> void:
	var first_item_slot: int = inventory.find_custom(func(x): return x != null)
	for i in range(get_stack_size()):
		inventory[i] = inventory[i + first_item_slot]
		inventory[i + first_item_slot] = null


func insert_to_first_open_slot(item: Resource) -> void:
	var first_open_slot: int = inventory.find_custom(func(x): return x == null)
	inventory[first_open_slot] = item
	print("insert")


func receive_item(item: Item) -> bool:
	if not active or null not in inventory:
		return false
	insert_to_first_open_slot(item)
	update_inv_label()
	return true


func generate_resource() -> void:
	var item: Resource = generation_resource.duplicate()
	insert_to_first_open_slot(item)
	update_inv_label()


func get_stack_size() -> int:
	return len(inventory) - inventory.count(null)


func update_inv_label() -> void:
	inventory_label.text = "Item: %s" % [get_stack_size()]


func activate_machine() -> void:
	$Sprite2D.modulate = Color(1, 1, 1, 1)
	active = true


func disable_machine() -> void:
	$Sprite2D.modulate = Color(0.8, 0.8, 0.8, 0.5)
	active = false


func toggle_machine() -> void:
	if active:
		disable_machine()
	else:
		activate_machine()


func rotate_machine(angle_diff: int) -> void:
	$Sprite2D.rotation_degrees += angle_diff
	port_dir = Vector2i(port_dir.y, -port_dir.x)
