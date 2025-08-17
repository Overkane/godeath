class_name Dummy
extends Node2D

signal died

@export var health_component: Health

@onready var hit_spot_body: Marker2D = %HitSpotBody


func _ready() -> void:
	health_component.died.connect(_die)


func hit(amount: int):
	health_component.take_damage(amount)

func get_hit_spot() -> Marker2D:
	return hit_spot_body


func _die() -> void:
	queue_free()
	died.emit()
