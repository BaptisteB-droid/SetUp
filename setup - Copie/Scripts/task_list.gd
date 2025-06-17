extends Control
class_name task_list_control

@onready var note_control : Control = $NoteControl
@onready var note_label : Label = $NoteControl/NoteLabel

@export var instructions : Array[String]

var is_visible : bool

func _ready() -> void:
	note_control.visible = false
	is_visible = false
	
	set_text(instructions[0])

func set_text(note_text : String):
	note_label.text = note_text

func appear():
	if !is_visible :
		note_control.visible = true
		is_visible = true
		
	else :
		note_control.visible = false
		is_visible = false
		set_text(instructions[1])


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("debug_task_appear"):
		appear()
