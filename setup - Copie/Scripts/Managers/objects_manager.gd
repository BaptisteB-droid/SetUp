extends Node
class_name objects_manager

@export var all_pickable_objects : Array[Node]
@export var needed_objects : Array[String]
@export var drop_zones : Array[Node]
@export var unused_items : Array[String]


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
	var available_spots : Array[drop_zone]
	
	for i in drop_zones:
		if i is drop_zone:
			if i.can_new_add_item:
				available_spots.append(i)
	
	if available_spots.size() > 0 and unused_items.size() > 0:
		var new_item_drop_zone : drop_zone = available_spots.pick_random()
		var item_to_add : String = unused_items.pick_random()
		unused_items.erase(item_to_add)
		
		new_item_drop_zone.items_number.append(item_to_add)
		new_item_drop_zone.items_target += 1
		
		print(item_to_add)
		
		if new_item_drop_zone.is_completed == true:
			new_item_drop_zone.is_completed = false
			EventManager.remove_wincheck()
			
		new_item_drop_zone.win_check(new_item_drop_zone.items_in_zone.size())
		
	else:
		print("NOUVELLE MISSION")  
		#ClientsManager.new_order()
	#Add pop-up to tell what to do
	
	pass


func remove_item():
	pass
