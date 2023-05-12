extends Camera2D

@export var tilemap : TileMap
@export var player : CharacterBody2D
	
func _process(delta):
	
	# Follow the player
	global_position = player.global_position

