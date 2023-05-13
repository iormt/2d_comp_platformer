extends Node2D

@export var spawnTimer : Timer 
@export var waveTimer : Timer
@export var positions : Node2D

const WAVE_INTERVAL = 5
const RANDOM_INTERVAL_VALUES = [25, 5]


const OBSTACLE = preload("res://Scenes/obstacle.tscn")




enum POSITION{
	TOP,
	MIDDLE,
	BOTTOM
}

var waves = [6, 12, 20, 30, 40] 
var wave_number = 1
var enemyTypes = [OBSTACLE]
var interval
var lastPosition 

func _ready():
	lastPosition = POSITION.BOTTOM 
	interval = (randi() % RANDOM_INTERVAL_VALUES[0] + RANDOM_INTERVAL_VALUES[1])/10.0

	
func _on_Timer_timeout():
	if waves:
		if waves[0] > 0:
			randomize()
			interval = (randi() % RANDOM_INTERVAL_VALUES[0] + RANDOM_INTERVAL_VALUES[1])/10.0
			enemyTypes.shuffle()
			spawnTimer.wait_time = interval
			var enemy = enemyTypes[0].instantiate()
			set_spawn_point(enemy)
			get_parent().add_child(enemy)
			waves[0] -= 1
		else:
			var wave_name
			if wave_number == 1:
				wave_name = "1st"
			elif wave_number == 2:
				wave_name = "2nd"
			elif wave_number == 3:
				wave_name = "3rd"
			else:
				wave_name = wave_number + "th"
			print("end of ", wave_name, " wave!")
			print("PREPARE FOR THE NEXT IN ", WAVE_INTERVAL, " SECONDS")
			waves.pop_front()
			wave_number += 1
			spawnTimer.autostart = false
			spawnTimer.stop()
			waveTimer.start(WAVE_INTERVAL)
	else:
		get_tree().change_scene("res://Scenes/UI/ScoreScreen.tscn")


func _on_WaveTimer_timeout():
	spawnTimer.autostart = true
	interval = (randi() % RANDOM_INTERVAL_VALUES[0] + RANDOM_INTERVAL_VALUES[1])/10.0
	spawnTimer.start(interval)
	
func set_spawn_point(enemy):
	if lastPosition == POSITION.TOP:
		enemy.global_position = positions.get_node("Middle").global_position
		lastPosition = POSITION.MIDDLE
	elif lastPosition == POSITION.MIDDLE:
		enemy.global_position = positions.get_node("Bottom").global_position
		lastPosition = POSITION.BOTTOM
	elif lastPosition == POSITION.BOTTOM:
		enemy.global_position = positions.get_node("Top").global_position
		lastPosition = POSITION.TOP
