class_name DummySpawner
extends Marker2D

signal dummy_died
signal dummy_took_damage(amount: int)

static var dummy_respawn_time: float = 3.0

@export var dummy_scene: PackedScene


func _ready() -> void:
	_init_dummy_spawn()


func _init_dummy_spawn() -> void:
	GameManager.dummy = null
	await get_tree().create_timer(dummy_respawn_time).timeout
	_spawn_dummy()

func _spawn_dummy() -> void:
	var dummy: Dummy = dummy_scene.instantiate()
	add_child(dummy)
	dummy.died.connect(_on_dummy_died)
	dummy.took_damage.connect(func(amount: int): dummy_took_damage.emit(amount))
	GameManager.dummy = dummy

func _on_dummy_died() -> void:
	dummy_died.emit()
	_init_dummy_spawn()
