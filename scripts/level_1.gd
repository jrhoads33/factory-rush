extends TileMapLayer

@export var map_size = 64
var map_data_dict = {}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for x in map_size:
		for y in map_size:
			map_data_dict[Vector2i(x-map_size/2,y-map_size/2)] = "Ground"
	
	for cord in map_data_dict:
		var random_floor_tile = randf()
		if random_floor_tile < 0.95:
			set_cell(cord, 0, Vector2i(0,0),0)
		elif random_floor_tile < .985:
			set_cell(cord, 0, Vector2i(1,0),0)
		else:
			set_cell(cord, 0, Vector2i(2,0), 0)
