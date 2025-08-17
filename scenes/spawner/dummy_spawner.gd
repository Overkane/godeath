extends Marker2D

@export var dummy_scene: PackedScene


func _ready() -> void:
	_init_dummy_spawn()


func _init_dummy_spawn() -> void:
	GameManager.dummy = null
	await get_tree().create_timer(GameManager.dummy_respawn_time).timeout
	_spawn_dummy()

func _spawn_dummy() -> void:
	var dummy: Dummy = dummy_scene.instantiate()
	add_child(dummy)
	dummy.died.connect(func(): _init_dummy_spawn())
	GameManager.dummy = dummy
