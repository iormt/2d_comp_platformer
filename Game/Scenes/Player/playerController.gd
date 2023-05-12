extends CharacterBody2D

@export var movement_controller : MovementController

func _physics_process(delta):
	movement_controller.coyote_time_timer(self, delta)
	
	movement_controller.add_gravity(self, delta)
		
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept"):
		movement_controller.jump(self)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	movement_controller.move_horizontally(self, direction)
	
	move_and_slide()
