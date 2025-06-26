class_name ClientsResource
extends Resource

enum missions_enum{TimeChange, NewItem, RemoveItem}

@export_group("Client Data")
@export var client_name : String
@export var client_image : Texture2D
@export var client_text : String
@export var missions_array : Array[missions_enum]
@export_subgroup("Timer Data")
#Put timer variables ?

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
			OnScreenTimer.mission_timechange(10)
			print("TimeChange")
		1:
			#Choose a new item to add to a zone	
			print("NewItem")
			ObjectsManager.new_item()

		2:
			#Choose an item to remove from a zone
			ObjectsManager.remove_item()
			print("RemoveItem")
	pass
