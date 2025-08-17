extends Node2D

@export var shooting_cooldown: float = 1.5
@export var projectile_scene: PackedScene

@onready var shooting_cooldown_timer: Timer = $ShootingCooldownTimer
@onready var gun_mount: Node2D = $GunMount
@onready var projectile_spawn_point: Marker2D = $GunMount/ProjectileSpawnPoint

func _ready() -> void:
	shooting_cooldown_timer.timeout.connect(_shoot)
	shooting_cooldown_timer.wait_time = shooting_cooldown

func _physics_process(delta: float) -> void:
	if GameManager.dummy != null:
		gun_mount.look_at(GameManager.dummy.get_hit_spot().global_position)


func _shoot() -> void:
	var projectile: Projectile = projectile_scene.instantiate()
	add_child(projectile)
	projectile.setup(projectile_spawn_point.global_position, Vector2.RIGHT.rotated(gun_mount.rotation))
