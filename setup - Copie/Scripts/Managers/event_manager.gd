extends Node3D
class_name event_manager

@export var events: Array[events_resource]
@export var current_event : events_resource

var zones_spawned : Array[drop_zone]
var total_win_check : int
var is_first_day : bool = true

func _ready() -> void:
	new_day()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("debug_skip"):
		new_day()

func new_day():
	TaskListControl.clear_text()
	#Premier jour pour éviter de destroy des trucs vides
	if is_first_day:
		current_event = events[0]
		events.remove_at(0)
		TaskListControl.set_text()
		TaskListControl.order_label_index = 0
		instantiate_events()
		is_first_day = false
		OnScreenTimer.new_mission_time()
		OnScreenTimer.prepare_next_client()
		ClientsManager.client_orders_count = 0

	else :
		if events.size() == 0:
			#fin du niveau tmtc
			print("FINI")
			remove_old_event()
		else :
			remove_old_event()
			#Set actual event to 1st in array
			current_event = events[0]
			events.remove_at(0)
			TaskListControl.set_text()
			TaskListControl.order_label_index = 0
			instantiate_events()
			OnScreenTimer.new_mission_time()
			OnScreenTimer.prepare_next_client()
			ClientsManager.client_orders_count = 0
	pass

func instantiate_events():
	print("_____")
	ObjectsManager.drop_zones.clear()
	#Spawn the different zones : 
	#For each zone, spawn one and set its size and location right 
	for n in current_event.zones_to_spawn.size():
		var instance : drop_zone = current_event.zones_to_spawn[n].dropzone_scene.instantiate()
		var instance_collision_shape : CollisionShape3D = instance.get_child(0)
		var instance_mesh_instance : MeshInstance3D = instance.get_child(1)
		
		instance.position = current_event.zones_to_spawn[n].zone_position
		instance.rotation = current_event.zones_to_spawn[n].zone_rotation
		instance_collision_shape.scale = current_event.zones_to_spawn[n].zone_scale
		instance_mesh_instance.scale = current_event.zones_to_spawn[n].zone_scale
		
		#Set items_target
		instance.items_target = current_event.zones_to_spawn[n].items_number.size()
		instance.items_number = current_event.zones_to_spawn[n].items_number
		instance.can_new_add_item = current_event.zones_to_spawn[n].can_add_new_item
		instance.can_remove_item = current_event.zones_to_spawn[n].can_remove_item
		instance.position_text = current_event.zones_to_spawn[n].task_position_text
		
		add_child(instance)
		zones_spawned.append(instance)
		ObjectsManager.get_needed_objects(instance)
		print("instanciated ",instance)
	
	ObjectsManager.get_unused_items()
	print("Remove")
	ObjectsManager.remove_item_set()
	print("Add")
	ObjectsManager.new_item_set()
	#Pop up the task list with the good information
	pass

#Liste de toutes les zones instantiés, quand elles sont toutes win, 
#passer a la next
#variable bool wincheck = true
#Compter toutes les zones et voir si elles sont vonne
func wincheckpassed():
	total_win_check += 1
	
	print(total_win_check)
	
	if total_win_check == zones_spawned.size() : 
		total_win_check = 0
		new_day()
		
	pass

func remove_wincheck(zone : drop_zone):
	print("Remove Wincheck")
	if total_win_check > 0:
		total_win_check -= 1
	print(total_win_check)
	zone.mesh_ref.material_override = zone.loose_material
	pass

func remove_old_event():
	#Find all the zones and destroy them
	for i in self.get_children():
		
		#Delete only dropzones to avoid destryong other children
		if i.is_in_group("DropZone"):
			print("remove",i)
			i.queue_free()
			zones_spawned.clear()
			zones_spawned = []
	pass

func event_lost():
	print("PERDU GROS PD")
	new_day()
	pass
