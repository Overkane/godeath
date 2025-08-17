class_name Projectile
extends Area2D

@export var _damage: int = 1
@export var _speed: int = 500

var _direction: Vector2


func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	global_position += _direction * _speed * delta


func setup(spawn_pos: Vector2, dir: Vector2) -> void:
	global_position = spawn_pos
	_direction = dir


func _on_body_entered(body: Node2D) -> void:
	if body is DummyBodyPart:
		var dummy_body_part = body as DummyBodyPart
		dummy_body_part.hit(_damage)
	queue_free()
