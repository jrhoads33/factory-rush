extends CharacterBody2D

var speed: float = 150.0

@onready var tile_layer: TileMapLayer = $"../Level1"
var machine_resource: MachineDefinition = preload("res://data/machines/converyer.tres")
var hopper_resource: MachineDefinition = preload("res://data/machines/collector_hopper.tres")

var selected_resource: MachineDefinition 
var inventory : Array[HotbarSlot] = []
var current_slot : int = 0

func _ready() -> void:
	setup_inventory()
	_update_current_item()

func setup_inventory() -> void:
	inventory.resize(5)
	for i in range(5):
		var slot : HotbarSlot = HotbarSlot.new()
		if i % 2:
			slot.definition = MachineLookup.machine_dict['conveyer']
		else:
			slot.definition = MachineLookup.machine_dict['hopper']
		slot.count = 1
		inventory[i] = slot 

func get_inv_slot(slot_num: int):
	"""
	Returns a MachineDefinition of that inv slot
	
	args:
		slot_num (int) = index of the inventory array
	returns: 
		MachineDefinition for what that slot has, an empty slot will return a null Machine Definition
	"""
	return inventory[slot_num].definition



func _physics_process(_delta: float) -> void:
	handle_movement()


func handle_movement() -> void:
	var input_dir := Vector2.ZERO
	input_dir.x = Input.get_axis("left", "right")
	input_dir.y = Input.get_axis("up", "down")
	velocity = input_dir.normalized() * speed
	move_and_slide()

func toggle_inv_slot() -> void:
	current_slot = (current_slot + 1) % inventory.size()
	selected_resource = get_inv_slot(current_slot)

func _update_current_item() -> void:
	selected_resource = get_inv_slot(current_slot)

func _place_machine(mouse_coords: Vector2i) -> void:
	if selected_resource == null:
		print("unable to place empty slot")
		return
	var success = GameManager.place_machine(mouse_coords, selected_resource)
	if success:
		inventory[current_slot] = HotbarSlot.new()
		_update_current_item()

func _unhandled_input(event: InputEvent) -> void:
	var mouse_coords: Vector2i = tile_layer.local_to_map(get_global_mouse_position())
	if event.is_action_pressed("interact_click"):
		_place_machine(mouse_coords)
	if event.is_action_pressed("Switch Inventory"):
		toggle_inv_slot()
	if event.is_action_pressed("rotate"):
		GameManager.attempt_rotate_machine(mouse_coords)
	if event.is_action_pressed("alt_interact_click"):
		GameManager.attempt_disable_machine(mouse_coords)
