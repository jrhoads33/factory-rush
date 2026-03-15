extends TileMapLayer
var last_tile = Vector2i(-1,-1)
@export var size = 32

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tile_set.tile_size.x = size
	tile_set.tile_size.y = size
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var tile = local_to_map(get_global_mouse_position())
	set_cell(tile,0, Vector2i(0,0), 0)
	if last_tile != tile:
		erase_cell(last_tile)
	last_tile = tile
