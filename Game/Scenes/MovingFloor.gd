extends StaticBody2D

@export var velocity : float
@export var camera : Camera2D
@export var tile_map : TileMap

var camera_left_border : float
var floor_width : float   


func _ready():
	floor_width = tile_map.get_used_rect().size.x * tile_map.cell_quadrant_size
	camera_left_border = camera.get_viewport_rect().position.x
	
func _process(delta):
	if position.x <= camera_left_border - floor_width:
		position.x = camera_left_border + floor_width - 9
	else:
		position.x -= velocity * delta
