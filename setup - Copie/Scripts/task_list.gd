extends Control
class_name task_list_control

@onready var note_control : Control = $NoteControl
@onready var intro_label : Label = $NoteControl/MarginContainer/TaskVBox/Task_Intro
@onready var outro_label : Label = $NoteControl/MarginContainer/TaskVBox/Task_Outro
@onready var body_label : Array[Label]

@onready var order_body_label : Array[Label]
var order_label_index : int

var instructions : task_resource

var is_visible_bool : bool

func _ready() -> void:
	
	note_control.visible = false
	is_visible_bool = false
	
	var body_label_container = $NoteControl/MarginContainer/TaskVBox/TaskVBox2
	for i in body_label_container.get_children() :
		if i is Label :
			body_label.append(i)
			
	
	var order_body_label_container = $NoteControl/MarginContainer/TaskVBox/TaskVBox3
	for i in order_body_label_container.get_children() :
		if i is Label :
			i.text = str(" ")
			order_body_label.append(i)

func set_text():
	instructions = EventManager.current_event.task_text_resource
	
	intro_label.text = str(" ")
	outro_label.text = str(" ")
	
	for j in body_label:
		j.text = str(" ")
	
	intro_label.text = instructions.task_intro
	outro_label.text = instructions.task_outro
	
	for i in instructions.task_body.size():
		body_label[order_label_index].text = instructions.task_body[i]
		order_label_index += 1
	pass

func appear():
	if !is_visible_bool :
		note_control.visible = true
		is_visible_bool = true
		
	else :
		note_control.visible = false
		is_visible_bool = false

func clear_text():
	
	if intro_label == null :
		intro_label = $NoteControl/MarginContainer/TaskVBox/Task_Intro
		outro_label = $NoteControl/MarginContainer/TaskVBox/Task_Outro
		
		var body_label_container = $NoteControl/MarginContainer/TaskVBox/TaskVBox2
		for i in body_label_container.get_children() :
			if i is Label :
				body_label.append(i)
		
		var order_body_label_container = $NoteControl/MarginContainer/TaskVBox/TaskVBox3
		for i in order_body_label_container.get_children() :
			if i is Label :
				order_body_label.append(i)
	
	intro_label.text = str(" ")
	outro_label.text = str(" ")
	
	for i in body_label:
		i.text = str(" ")
	
	for j in order_body_label:
		j.text = str("  ")
	
	order_label_index = 0
	pass

func set_order_text(current_mission : int):
	match current_mission:
		0:
			var m = int(OnScreenTimer.mission_end_time/60)
			var s = OnScreenTimer.mission_end_time - m * 60
			order_body_label[order_label_index].text = str("New deadline : ", '%02d : %02d' % [m, s])
		1:
			var added_object : String = ObjectsManager.task_item.to_lower()
			var target_zone : String = ObjectsManager.task_zone
			order_body_label[order_label_index].text = str("Add a ", added_object," ", target_zone)
		2:
			var removed_object : String = ObjectsManager.task_item.to_lower()
			var target_zone : String = ObjectsManager.task_zone
			order_body_label[order_label_index].text = str("Remove a ", removed_object, " from ", target_zone)
	
	order_label_index += 1
	pass

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("debug_task_appear"):
		appear()
