extends Node2D
class_name MovementController

@export var speed : float = 150.0
@export var jump_velocity : float = -350.0
@export var coyote_time : float = 0.1
@export var fall_gravity_scale : float = 1.5
@export var max_jumps : int = 2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_timer : float = 0
var jumps_left : int = max_jumps
var is_on_ground : bool = false


func move_horizontally(characer_body : CharacterBody2D, direction : float) -> void:
	if direction:
		characer_body.velocity.x = direction * speed
	else:
		characer_body.velocity.x = move_toward(characer_body.velocity.x, 0, speed)

func jump(characer_body : CharacterBody2D) -> void:
	if is_on_ground or jump_timer < coyote_time or jumps_left > 0:
		characer_body.velocity.y = jump_velocity
		jumps_left -= 1

func coyote_time_timer(characer_body : CharacterBody2D, delta : float) -> void:
	if characer_body.is_on_floor():
		is_on_ground = true
		jump_timer = 0
		jumps_left = max_jumps
		
	else:
		is_on_ground = false
		jump_timer += delta

func add_gravity(characer_body : CharacterBody2D, delta : float) -> void:
	if not is_on_ground:
		if characer_body.velocity.y <= 0:
			characer_body.velocity.y += gravity * delta
		elif characer_body.velocity.y > 0:
			characer_body.velocity.y += gravity * fall_gravity_scale * delta
