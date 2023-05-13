extends StaticBody2D

@export var base_speed : float = 50 
@export var button_sprite : Sprite2D

var added_speed : float = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x -= (base_speed + added_speed) * delta

func _on_area_2d_body_entered(body):
	if is_instance_of(body, Player):
		button_sprite.frame = 1
		$DestructionTimer.start()

func _on_destruction_timer_timeout():
	queue_free()


