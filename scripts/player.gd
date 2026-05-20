extends CharacterBody2D

var speed: float = 150.0

@onready var tile_layer: TileMapLayer = $"../Level1"
var machine_scene: PackedScene = preload("res://scenes/machine.tscn")
var selected_resource: MachineDefinition = preload("res://data/machines/converyer.tres")


func _physics_process(_delta: float) -> void:
	handle_movement()


func handle_movement() -> void:
	var input_dir := Vector2.ZERO
	input_dir.x = Input.get_axis("left", "right")
	input_dir.y = Input.get_axis("up", "down")
	velocity = input_dir.normalized() * speed
	move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	var mouse_coords: Vector2i = tile_layer.local_to_map(get_global_mouse_position())
	if event.is_action_pressed("interact_click"):
		GameManager.place_machine(mouse_coords, machine_scene, selected_resource)
	if event.is_action_pressed("rotate"):
		GameManager.attempt_rotate_machine(mouse_coords)
	if event.is_action_pressed("alt_interact_click"):
		GameManager.attempt_disable_machine(mouse_coords)
