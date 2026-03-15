extends TileMapLayer

@export var map_size = 64
var map_data_dict = {}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for x in map_size:
		for y in map_size:
			map_data_dict[Vector2(x-map_size/2,y-map_size/2)] = "Ground"
	
	for cord in map_data_dict:
		set_cell(cord, 0, Vector2i(0,0),0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
