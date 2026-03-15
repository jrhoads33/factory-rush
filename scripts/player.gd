extends CharacterBody2D


var speed = 150.0
const JUMP_VELOCITY = -400.0
#var factory_manager: PackedScene
@onready var tile_layer: TileMapLayer = $"../Level1"
var machine_scene: PackedScene = preload("res://scenes/machine.tscn")
var selected_resource: Resource = preload("res://data/machines/converyer.tres")



func _physics_process(delta: float) -> void:
	handle_movement()

func handle_movement() -> void:
	var input_dir = Vector2.ZERO

	input_dir.x = Input.get_axis("left", "right")
	input_dir.y = Input.get_axis("up", "down")
		
	input_dir = input_dir.normalized()
	velocity = input_dir * speed


	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		var coords = tile_layer.local_to_map(get_global_mouse_position())
		var success = GameManager.place_machine(coords, machine_scene, selected_resource)
		print(success)
