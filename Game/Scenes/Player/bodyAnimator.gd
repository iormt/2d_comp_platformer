extends Node2D

@export var char_body : CharacterBody2D
@export var movement_controller : MovementController
@export var animation_player : AnimationPlayer

var _scale
# Called when the node enters the scene tree for the first time.
func _ready():
	_scale = scale


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	if char_body.is_on_floor() and char_body.velocity.x != 0:
		animation_player.play("run")
	elif (not char_body.is_on_floor() and char_body.velocity.y < 0 and movement_controller.max_jumps - movement_controller.jumps_left 
		<= movement_controller.max_jumps - 1):
		animation_player.play("jump_up")
	elif (not char_body.is_on_floor() 
		and movement_controller.max_jumps - movement_controller.jumps_left 
		> movement_controller.max_jumps - 1):
		animation_player.play("double_jump")
	elif not char_body.is_on_floor() and char_body.velocity.y >= 0:
		animation_player.play("jump_down")
	else:
		animation_player.play("run")
		

