extends Area3D
class_name drop_zone

var items_in_zone: Array[String] = []
var win_check_bool : bool = false

@export_group("Conditions")
@export var items_target : int = 1
@export var items_number : Array[String]


@export_group("Materials")
@export var win_material : Material
@export var loose_material : Material

@onready var trigger_zone = $CollisionShape3D

func _ready() -> void:
	pass

func _on_body_entered(body: Node3D) -> void:
	
	if body.is_in_group("PickableObjects"):
		
		var po_parent: pickable_object = body.get_parent_node_3d()
		
		var body_name = po_parent.po_name
		
		items_in_zone.append(body_name)
		
		print(items_in_zone)
		
		win_check(items_in_zone.size())
		

func _on_body_exited(body: Node3D) -> void:
	
	if body.is_in_group("PickableObjects"):
		
		var po_parent: pickable_object = body.get_parent_node_3d()
		var body_name = po_parent.po_name
		
		items_in_zone.erase(body_name)
		
		win_check(items_in_zone.size())

func win_check(total_items : int):
	
	if total_items == items_target :
		var array_comparator : Array[String] = items_number
		
		array_comparator.sort()
		items_in_zone.sort()
		
		print(array_comparator)
		print(items_in_zone )
		
		if array_comparator == items_in_zone:
			
			$MeshInstance3D.material_override = win_material
			win_check_bool = true
			
		else :
			$MeshInstance3D.material_override = loose_material
			win_check_bool = false
		
	if total_items != items_target :
		$MeshInstance3D.material_override = loose_material
		win_check_bool = false
