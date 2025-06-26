extends Area3D
class_name drop_zone

var items_in_zone: Array[String]
var is_completed : bool = false

@export_group("Conditions")
@export var items_target : int = 1
@export var items_number : Array[String]
@export var can_new_add_item : bool = false
@export var can_remove_item : bool = false


@export_group("Materials")
@export var win_material : Material
@export var loose_material : Material

@onready var trigger_zone = $CollisionShape3D

func _ready() -> void:
	pass

func _on_body_entered(body: Node3D) -> void:
	
	if body.is_in_group("PickableObjects") and pickable_object:
		
		items_in_zone.append(body.po_name)
		win_check(items_in_zone.size())
		
		print(body.po_name)

func _on_body_exited(body: Node3D) -> void:
	
	if body.is_in_group("PickableObjects") and pickable_object:
		
		items_in_zone.erase(body.po_name)
		
		win_check(items_in_zone.size())

func win_check(total_items : int):
	if total_items == items_target :
		var array_comparator : Array[String] = items_number
		array_comparator.sort()
		items_in_zone.sort()
	
		if array_comparator == items_in_zone:
			is_completed = true
			$MeshInstance3D.material_override = win_material
			EventManager.wincheckpassed()
		else :
			is_completed = false
			$MeshInstance3D.material_override = loose_material
		
	else :
		is_completed = false
		$MeshInstance3D.material_override = loose_material
