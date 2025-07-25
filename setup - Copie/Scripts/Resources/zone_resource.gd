extends Resource
class_name zone_resource

@export_group("Spawn Data")
@export var dropzone_scene : PackedScene
@export_subgroup("Zone Transform")
@export var zone_position : Vector3
@export var zone_rotation : Vector3
@export var zone_scale : Vector3

@export_group("Zone Conditions")
@export var items_number : Array[String]
@export var can_add_new_item : bool
@export var can_remove_item : bool

@export_group("Other")
@export var task_position_text : String
