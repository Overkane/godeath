class_name Health
extends Node

signal died

@export var _max_health: int = 1
var _current_health: int = _max_health:
	set(value):
		_current_health = clampi(value, 0, _max_health)
		if _current_health == 0:
			died.emit()


func _ready() -> void:
	_current_health = _max_health


func take_damage(amount: int) -> void:
	_current_health -= amount