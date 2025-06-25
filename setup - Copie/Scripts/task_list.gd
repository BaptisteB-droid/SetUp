extends Control
class_name task_list_control

@onready var note_control : Control = $NoteControl
@onready var note_label : Label = $NoteControl/NoteLabel

@export var instructions : Array[String]

var is_visible_bool : bool

func _ready() -> void:
	
	note_control.visible = false
	is_visible_bool = false
	

func set_text(note_text : String):
	note_label.text = note_text

func appear():
	if !is_visible_bool :
		note_control.visible = true
		is_visible_bool = true
		
	else :
		note_control.visible = false
		is_visible_bool = false

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("debug_task_appear"):
		appear()
