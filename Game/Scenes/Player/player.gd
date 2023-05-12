extends CharacterBody2D


@export var speed : float = 150.0
@export var jump_velocity : float = -350.0
@export var coyote_time : float = 0.1
@export var fall_gravity_scale : float = 1.5
@export var max_jumps : int = 2

@export var wall_slide_speed : float = 50.0
@export var wall_jump_velocity : float = -450.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_timer : float = 0
var jumps_left : int = max_jumps
var is_on_ground : bool = false


func _physics_process(delta):
	coyote_time_timer(delta)
	
	add_gravity(delta)
		
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept"):
		jump()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	move(direction)
	
	move_and_slide()

func move(direction):
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

func jump():
	if is_on_ground or jump_timer < coyote_time or jumps_left > 0:
		velocity.y = jump_velocity
		jumps_left -= 1

func coyote_time_timer(delta):
	if is_on_floor():
		is_on_ground = true
		jump_timer = 0
		jumps_left = max_jumps
		
	else:
		is_on_ground = false
		jump_timer += delta

func add_gravity(delta):
	if not is_on_ground:
		if velocity.y <= 0:
			velocity.y += gravity * delta
		elif velocity.y > 0:
			velocity.y += gravity * fall_gravity_scale * delta
