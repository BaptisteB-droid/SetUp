extends Node3D
class_name event_manager

@export var events: Array[events_resource]
@export var current_event : events_resource

var zones_spawned : Array[drop_zone]

func _ready() -> void:
	
	new_day()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("debug_skip"):
		new_day()

func new_day():
	
	remove_old_event()
	
	if events.size() == 0:
		#fin du niveau tmtc
		print("FINI")
	else :
		
		#Set actual event to 1st in array
		current_event = events[0]
		events.remove_at(0)
		
		instantiate_events()
	pass

func instantiate_events():
	
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
		
		print(current_event.zones_to_spawn[n].items_number)
		
		add_child(instance)
		zones_spawned.append(instance)
		print(zones_spawned)
	
	#Pop up the task list with the good information
	
	pass

#Liste de toutes les zones instantiés, quand elles sont toutes win, passer a la next
#variable bool wincheck = true
func wincheckpassed():
	pass

func remove_old_event():
	#Find all the zones and destroy them
	for i in self.get_children():
		
		self.remove_child(i)
	pass
