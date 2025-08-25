class_name Dummy
extends Node2D

signal died
signal took_damage(damage: int)

@export var health_component: DummyHealth

var is_dead := false

@onready var hit_spot_body: Marker2D = %HitSpotBody
@onready var left_hand_force_point: Marker2D = %LeftHandForcePoint
@onready var right_hand_force_point: Marker2D = %RightHandForcePoint
@onready var left_leg_force_point: Marker2D = %LeftLegForcePoint
@onready var right_leg_force_point: Marker2D = %RightLegForcePoint
@onready var body: RigidBody2D = $Body
@onready var left_hand: RigidBody2D = $LeftHand
@onready var right_hand: RigidBody2D = $RightHand
@onready var left_leg: RigidBody2D = $LeftLeg
@onready var right_leg: RigidBody2D = $RightLeg


func _ready() -> void:
	health_component.died.connect(_on_died)

func _physics_process(delta: float) -> void:
	_simulate_pain()


func hit(amount: int):
	took_damage.emit(amount)
	health_component.take_damage(amount)
	_apply_hit_force()

func get_hit_spot() -> Marker2D:
	return hit_spot_body


func _apply_hit_force() -> void:
	var force = randi_range(75, 150) * (1 - float(health_component._current_health) / float(health_component.max_health))
	var direction = Vector2.RIGHT.rotated(randf_range(0, TAU - 1))
	var impulse = force * direction

	body.apply_impulse(impulse, hit_spot_body.global_position)

func _simulate_pain() -> void:
	var hand_direction := Vector2.UP.rotated(randf_range(-PI/2, PI/2)) if (randi() % 2 == 1) else Vector2.DOWN.rotated(randf_range(-PI/2, PI/2))
	var leg_direction := Vector2.UP.rotated(randf_range(-PI/2, PI/2)) if (randi() % 2 == 1) else Vector2.DOWN.rotated(randf_range(-PI/2, PI/2))
	var force = 500 * (1 - float(health_component._current_health) / float(health_component.max_health))

	right_hand.apply_force(force * hand_direction, right_hand_force_point.global_position)
	left_hand.apply_force(force * hand_direction, left_hand_force_point.global_position)
	left_leg.apply_force(force * leg_direction, left_leg_force_point.global_position)
	right_leg.apply_force(force * leg_direction, right_leg_force_point.global_position)

func _on_died() -> void:
	if is_dead:
		return
	is_dead = true
	died.emit()
	queue_free()
