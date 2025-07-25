extends Control
class_name on_screen_timer

@onready var label : Label = $PanelContainer/MarginContainer/VBoxContainer/Label_Timer
@onready var timer : Timer = $Timer_Timer
@onready var deadline_label

@export_group("Timer")
@export var total_time_seconds : int = 420
@export var begin_time : String
@export var second_speed : float

@export_group("Orders")
var new_order_delay : float
@export var roll_ration : float
@export var min_normal : float
@export var max_normal : float
@export var min_calm : float
@export var max_calm : float

var new_order_time : float
var first_call : bool = true
var time_for_mission : int
var mission_end_time : int
var mission_ongoing : bool = true
var debug_bool : bool = true


func _ready() -> void:
	timer.wait_time = second_speed
	timer.start()
	label.text = begin_time

func new_mission_time():
	time_for_mission = EventManager.current_event.timer
	mission_end_time = total_time_seconds + time_for_mission
	
	deadline_label = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Label_Deadline_Time
	
	var m = int(mission_end_time/60)
	var s = mission_end_time - m * 60
	deadline_label.text = '%02d : %02d' % [m, s]

func prepare_next_client():
	var roll = randf()
	if roll >= roll_ration: 
		new_order_delay = randf_range(min_normal, max_normal)
	else:
		new_order_delay = randf_range(min_calm, max_calm)
	
	new_order_delay = roundf(new_order_delay)
	new_order_time = total_time_seconds + new_order_delay
	
	first_call = true


func _process(_delta: float) -> void:
	if total_time_seconds == new_order_time and ClientsManager.client_orders_count < ClientsManager.max_client_orders:
		call_new_order()
	
	#Si le timer dépasse alors faire perdre
	if total_time_seconds >= mission_end_time and mission_ongoing:
		EventManager.event_lost()
		mission_ongoing = false
	pass

func call_new_order():
	if first_call: 
		ClientsManager.new_order()
		first_call = false
		prepare_next_client()
		ClientsManager.client_orders_count += 1


func mission_timechange(time_less_min : float, time_less_max : float):
	
	var time_less : float
	
	time_less = roundi(randf_range(time_less_min, time_less_max))
	mission_end_time -= time_less
	
	var m = int(mission_end_time/60)
	var s = mission_end_time - m * 60
	deadline_label.text = '%02d : %02d' % [m, s]
	
	pass


func _on_timer_timeout() -> void:
	total_time_seconds += 1
	
	var m = int(total_time_seconds/60)
	var s = total_time_seconds - m * 60
	label.text = '%02d : %02d' % [m, s]
