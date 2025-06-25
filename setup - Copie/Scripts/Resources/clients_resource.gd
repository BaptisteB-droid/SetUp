class_name ClientsResource
extends Resource

enum missions_enum{Move, TimeChange, NewItem, RemoveItem}

@export_group("Client Data")
@export var client_name : String
@export var client_image : Texture2D
@export var client_text : String
@export var missions_array : Array[missions_enum]

@export_group("Mission Data")
@export var min_chance : float
@export var max_chance : float


func choose_mission():
	var chosen_mission = missions_array.pick_random()
	mission_gameplay(chosen_mission)
	pass

func mission_gameplay(current_mission : int):
	match current_mission:
		0:
			print("Move")
		1:
			OnScreenTimer.mission_timechange(10)
		2:
			print("NewItem")
			#Choose a new item to add to a zone
		3:
			print("RemoveItem")
			#Choose an item to remove from a zone
	pass
