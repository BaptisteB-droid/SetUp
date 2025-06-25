extends Node3D
class_name clients_manager

@export var clients : Array[ClientsResource]

@onready var client_control : Control = $Clients_Control
@onready var order_label : Label = $Clients_Control/Order_Label
@onready var name_label : Label = $Clients_Control/Name_Label
@onready var image_texture : TextureRect = $Clients_Control/Image_Texture


func new_order():
	var acting_client = clients[randf_range(0, clients.size())]
	mission_ui(acting_client)
	mission_gameplay(acting_client)


func mission_ui(client_data : ClientsResource):
	pass
	#image_texture.texture = client_data.client_image
	name_label.text = client_data.client_name
	#order_label.text = client_data.client_text


func mission_gameplay(client_data : ClientsResource):
	client_data.choose_mission()
	pass
