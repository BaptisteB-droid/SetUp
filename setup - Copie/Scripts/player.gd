extends CharacterBody3D

@export var base_speed: float = 200.0
@export var sprint_speed: float = 500.0
var speed: float = 200.0

var movement_input = Vector2.ZERO

@onready var raycast = $Hands/RayCast3D
@onready var hand = $Hands

var picked_object: Node3D
@export var pull_power = 10

func _ready() -> void:
	speed = base_speed


func _physics_process(delta: float) -> void:
 	
	if picked_object != null:
		picked_object.global_position = hand.global_position
	
	if Input.is_action_pressed("sprint"):
		speed = sprint_speed
	else : 
		speed = base_speed
	
	if Input.is_action_pressed("backward") || Input.is_action_pressed("forward") || Input.is_action_pressed("right") || Input.is_action_pressed("left"):	
		
		movement_input = Input.get_vector("left", "right", "forward", "backward")
		velocity = Vector3(movement_input.x,0,movement_input.y) * speed * delta
		rotation.y = lerp_angle(rotation.y, atan2(velocity.x, velocity.z), 0.5)
		move_and_slide()

	if Input.is_action_just_pressed("interact"): 
		if picked_object != null:
			drop_object()
		elif picked_object == null:
			pick_object()

func pick_object():
	var collider = raycast.get_collider()
	if collider != null and collider is RigidBody3D and collider.is_in_group("PickableObjects"):
		picked_object = collider
		picked_object.get_node("CollisionShape3D").disabled = true


func drop_object():
	if picked_object != null:
		picked_object.get_node("CollisionShape3D").disabled = false
		picked_object = null
