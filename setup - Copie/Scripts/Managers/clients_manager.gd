extends Node3D
class_name clients_manager

@export var clients : Array[ClientsResource]

@onready var client_control : Control = $Clients_Control
@onready var order_label : Label = $Clients_Control/PanelContainer/MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/Order_Label
@onready var flair_label : Label = $Clients_Control/PanelContainer/MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/Flair_Label
@onready var name_label : Label = $Clients_Control/PanelContainer/MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/Name_Label
@onready var image_texture : TextureRect = $Clients_Control/PanelContainer/MarginContainer/HBoxContainer/Image_Texture

var max_client_orders : int
var client_orders_count : int = 0
@export var client_max_time_on_screen : float
var client_time_on_screen : float

func _ready() -> void:
	max_client_orders = EventManager.current_event.max_task_number
	client_control.visible = false

func _process(delta: float) -> void:
	if client_control.visible == true:
		client_time_on_screen += delta
		if client_time_on_screen >= client_max_time_on_screen:
			client_control.visible = false
			client_time_on_screen = 0

func new_order():
	var acting_client = clients[randf_range(0, clients.size())]
	mission_ui(acting_client)
	mission_gameplay(acting_client)


func mission_ui(client_data : ClientsResource):
	client_control.visible = true
	print("oui")
	flair_label.text = client_data.client_flair
	name_label.text = client_data.client_name
	#order_label.text = client_data.client_text


func mission_gameplay(client_data : ClientsResource):
	client_data.choose_mission()
	pass
