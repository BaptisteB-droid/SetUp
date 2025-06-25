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
	
	var only_in_all : Array[String]
	
	for j in all_pickable_objects:
		if j is pickable_object:
			print(needed_objects)
			if not (j in needed_objects):
				print("Oui")
				only_in_all.append(j)
				print(j.po_name)
	
	unused_items = only_in_all

func new_item():
	pass


func remove_item():
	pass
