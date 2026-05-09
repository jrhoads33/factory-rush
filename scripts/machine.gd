extends Node2D

@export var machine_resource : MachineDefinition
var grid_pos : Vector2i
var inventory_label : Label
var inventory_slots : int = 1
var inventory : Array = []
var generation_resource: Resource = preload("res://scripts/resource_definitions/stone_item.tres")

#var inventory
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.texture = machine_resource.texture if machine_resource.texture else $Sprite2D.texture
	setup_inventory()

func setup_inventory():
	"""Assigns Inventory Slots and Inventory Labels"""
	inventory_slots = machine_resource.inventory_slots
	inventory.resize(inventory_slots)
	inventory_label = $InventoryLabel
	update_inv_label()

func shift_inventory():
	var first_item_slot = inventory.find_custom(func(x): return x != null)
	for i in range(get_stack_size()):
		inventory[i] = inventory[i+first_item_slot]
		inventory[i+first_item_slot] = null


func update_inv_label() -> void:
	inventory_label.text = "Item: %s" % [get_stack_size()]

func get_stack_size() -> int:
	""" Returns the number of items in the inventory """
	return len(inventory) - inventory.count(null)


func _on_process_timer_timeout() -> void:
	"""triggers actions for process timer or a tick"""
	var right_machine = GameManager.factory_manager.get_tile(grid_pos + Vector2i(1,0))

	if right_machine != null and inventory[0] != null:
		var success = right_machine.machine_ref.receive_item(inventory[0])
		print("inv transfer {0}".format([success]))
		if success:
			inventory[0] = null
			shift_inventory()
			update_inv_label()
	
func insert_to_first_open_slot(item):
	var first_open_slot = inventory.find_custom(func(x): return x == null)
	inventory[first_open_slot] = item
	print("insert")


func receive_item(item: Item) -> bool:
	if null not in inventory:
		print("inv full")
		return false
	insert_to_first_open_slot(item)
	update_inv_label()
	return true


func _on_generate_timer_timeout() -> void:
	var item = generation_resource.duplicate()

	if null in inventory:
		insert_to_first_open_slot(item)
	update_inv_label()
		


func _on_debug_timer_timeout() -> void:
	print("inventory", inventory)
