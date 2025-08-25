class_name DummyHealth
extends Node

signal died

static var max_health: int = 5
var _current_health: int = max_health:
	set(value):
		_current_health = clampi(value, 0, max_health)
		if _current_health == 0:
			died.emit()


func _ready() -> void:
	_current_health = max_health


func take_damage(amount: int) -> void:
	_current_health -= amount
