extends Camera3D
class_name camera_manager

@export_group("Camera Transform")
@export var camera_position : Vector3
@export var camera_rotation : Vector3

@export var z_offset : int = 4
var camera_follow : bool
var player_ref : player

func _ready() -> void:
	player_ref = get_tree().get_first_node_in_group("Player")


func _process(delta: float) -> void:
	if camera_follow : 
		var player_pos = player_ref.position
		position = Vector3(player_pos.x, position.y , player_pos.z + z_offset)
		
	pass
