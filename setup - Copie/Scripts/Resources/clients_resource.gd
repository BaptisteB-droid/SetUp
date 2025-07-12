class_name ClientsResource
extends Resource

enum missions_enum{TimeChange, NewItem, RemoveItem}

@export_group("Client Data")
@export var client_name : String
@export var client_image : Texture2D
@export var client_flair : String
@export var missions_array : Array[missions_enum]
@export_subgroup("Timer Data")
#Put timer variables ?

@export_group("Mission Data")
@export var min_chance : float
@export var max_chance : float
@export var client_time_less : float
@export_subgroup("Time Change Mission")
@export var time_less_min : float
@export var time_less_max : float


func choose_mission():
	var chosen_mission = missions_array.pick_random()
	mission_gameplay(chosen_mission)
	pass

func mission_gameplay(current_mission : int):
	match current_mission:
		0:
			print("TimeChange")
			OnScreenTimer.mission_timechange(time_less_min, time_less_max)
		1:
			#Choose a new item to add to a zone	
			print("NewItem")
			ObjectsManager.new_item()
		2:
			#Choose an item to remove from a zone
			print("RemoveItem")
			ObjectsManager.remove_item()
			
	TaskListControl.set_order_text(current_mission)
	pass
