class_name events_resource
extends Resource

@export_group("Event Data")
@export_subgroup("Zones")
@export var zones_to_spawn : Array[zone_resource]
@export_subgroup("Task Resource")
@export var task_text_resource : task_resource
@export_range(1,3) var max_task_number : int

@export var timer : float
