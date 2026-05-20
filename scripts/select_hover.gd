extends TileMapLayer

var last_tile: Vector2i = Vector2i(-1, -1)

@export var size: int = 32


func _ready() -> void:
	tile_set.tile_size.x = size
	tile_set.tile_size.y = size


func _process(_delta: float) -> void:
	var tile: Vector2i = local_to_map(get_global_mouse_position())
	set_cell(tile, 0, Vector2i(0, 0), 0)
	if last_tile != tile:
		erase_cell(last_tile)
	last_tile = tile
