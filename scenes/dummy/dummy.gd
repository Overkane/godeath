class_name Dummy
extends Node2D

signal died
signal took_damage(damage: int)

@export var health_component: Health

var is_dead := false

@onready var hit_spot_body: Marker2D = %HitSpotBody


func _ready() -> void:
	health_component.died.connect(_on_died)


func hit(amount: int):
	took_damage.emit(amount)
	health_component.take_damage(amount)

func get_hit_spot() -> Marker2D:
	return hit_spot_body


func _on_died() -> void:
	if is_dead:
		return
	died.emit()
	queue_free()
