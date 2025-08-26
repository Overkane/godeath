extends Node2D

@export var shooting_cooldown: float = 1.5
@export var projectile_scene: PackedScene

@onready var shooting_cooldown_timer: Timer = $ShootingCooldownTimer
@onready var gun_mount: Node2D = $GunMount
@onready var projectile_spawn_point: Marker2D = $GunMount/ProjectileSpawnPoint

var can_shoot := false
var target: Dummy = null

func _ready() -> void:
	shooting_cooldown_timer.timeout.connect(func(): can_shoot = true)
	shooting_cooldown_timer.start(shooting_cooldown)

func _physics_process(delta: float) -> void:
	if can_shoot and target == null:
		var dummies: Array = get_tree().get_nodes_in_group("dummy")
		if not dummies.is_empty():
			target = get_tree().get_nodes_in_group("dummy").pick_random()

	if target != null:
		# TODO add lerp later
		gun_mount.look_at(target.get_hit_spot().global_position)
		if can_shoot:
			_shoot()


func _shoot() -> void:
	can_shoot = false
	shooting_cooldown_timer.start(shooting_cooldown)
	var projectile: Projectile = projectile_scene.instantiate()
	get_tree().root.add_child(projectile)
	projectile.setup(projectile_spawn_point.global_position, Vector2.RIGHT.rotated(gun_mount.rotation))
