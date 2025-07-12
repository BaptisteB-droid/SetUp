extends Area3D
class_name camera_zone

@export var room_data : CameraResource
@onready var camera : camera_manager

@export var follow_player : bool = false

var camera_moving : bool = false
var t = 0.0

@onready var collisionshape : CollisionShape3D = $CollisionShape3D

func _ready() -> void:
	var _t = 0.0
	collisionshape.scale = room_data.collisionshape_scale
	
	var camera_array = get_tree().get_nodes_in_group("Camera")
	camera = camera_array[0]

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		camera.camera_follow = follow_player
		camera.position = room_data.camera_position
