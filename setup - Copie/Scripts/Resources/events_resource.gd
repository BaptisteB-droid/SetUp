class_name events_resource
extends Resource

@export_group("Event Data")
@export_subgroup("Zones")
@export var zones_to_spawn : Array[zone_resource]

@export var timer : float
