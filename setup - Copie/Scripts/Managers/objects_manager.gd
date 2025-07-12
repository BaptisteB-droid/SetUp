extends Node
class_name objects_manager

@export var all_pickable_objects : Array[Node]
@export var needed_objects : Array[String]
@export var drop_zones : Array[Node]

var unused_items : Array[String]
var remove_item_available_spots : Array[drop_zone]
var new_item_available_spots : Array[drop_zone]
var task_item : String
var task_zone : String


func get_needed_objects(spawned_zone : drop_zone):
	#Mark all zones and objects
	drop_zones.append(spawned_zone)
	needed_objects.append_array(spawned_zone.items_number)

func get_unused_items():
	all_pickable_objects = get_tree().get_nodes_in_group("PickableObjects")
	
	var pickable_names : Array[String]
	var temp_all_items : Array[String]
	var temp_needed_objects : Array[String]
	
	temp_needed_objects = needed_objects
	
	for i in all_pickable_objects:
		if i is pickable_object:
			pickable_names.append(i.po_name)
	
	temp_all_items = pickable_names
	
	temp_all_items.sort()
	temp_needed_objects.sort()
	
	for j in temp_needed_objects:
		temp_all_items.erase(j)
	
	unused_items = temp_all_items

func new_item():
	
	if new_item_available_spots.size() > 0 and unused_items.size() > 0:
		var new_item_drop_zone : drop_zone = new_item_available_spots.pick_random()
		var item_to_add : String = unused_items.pick_random()
		unused_items.erase(item_to_add)
		
		new_item_drop_zone.items_number.append(item_to_add)
		new_item_drop_zone.items_target += 1
		
		print(item_to_add)
		task_item = item_to_add
		task_zone = new_item_drop_zone.position_text
		
		if new_item_drop_zone.is_completed == true:
			new_item_drop_zone.is_completed = false
			EventManager.remove_wincheck(new_item_drop_zone)
			
		new_item_drop_zone.win_check(new_item_drop_zone.items_in_zone.size())
		
	else:
		print("NOUVELLE MISSION")  
		#ClientsManager.new_order()
	#Add pop-up to tell what to do
	pass


func remove_item():
	
	print(remove_item_available_spots)
	
	if remove_item_available_spots.size() > 0:
		var chosen_zone : drop_zone = remove_item_available_spots.pick_random()
		var removed_item = chosen_zone.items_number.pick_random()
		
		chosen_zone.items_number.erase(removed_item)
		chosen_zone.items_target -= 1
		
		task_item = removed_item
		task_zone = chosen_zone.position_text
		
		print(removed_item)
		
		if chosen_zone.is_completed == true:
			print("True")
			chosen_zone.is_completed = false
			EventManager.remove_wincheck(chosen_zone)
		else:
			print("False")
			chosen_zone.win_check(chosen_zone.items_in_zone.size())
		
	else:
		print("NOUVELLE MISSION")  
		#ClientsManager.new_order()
	#Add pop-up to tell what to do
	
	pass



func remove_item_set():
	remove_item_available_spots = []
	
	for i in drop_zones:
		if i is drop_zone:
			if i.can_remove_item:
				remove_item_available_spots.append(i)
	
	pass


func new_item_set():
	new_item_available_spots = []
	
	for i in drop_zones:
		if i is drop_zone:
			if i.can_new_add_item:
				new_item_available_spots.append(i)
	
	pass
