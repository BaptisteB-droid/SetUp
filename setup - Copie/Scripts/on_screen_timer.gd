extends Control
class_name OnScreenTimer

@onready var label = $Label
@onready var timer = $Timer
@export var total_time_seconds : int = 420

@export var begin_time : String
@export var second_speed : float

func _ready() -> void:
	
	timer.wait_time = second_speed
	
	print(timer.wait_time)
	timer.start()
	label.text = begin_time


func _on_timer_timeout() -> void:
	
	total_time_seconds += 1
	
	var m = int(total_time_seconds/60)
	var s = total_time_seconds - m * 60
	
	label.text = '%02d : %02d' % [m, s]
