extends Node2D

signal game_won

const DEATHS_AMOUNT_TO_WIN: int = 1_000_000

var deaths_amount: int    = 0:
	set(value):
		deaths_amount = value
		if deaths_amount >= DEATHS_AMOUNT_TO_WIN:
			game_won.emit()
var godocoins_amount: int = 1
var is_in_building_mode := false

@onready var hud: HUD = $HUD
@onready var availability_grid: AvailabilityGrid = $AvailabilityGrid
@onready var walls_grid: TileMapLayer = $Walls
@onready var building_grid: TileMapLayer = $BuildingGrid
@onready var dummy_spawner: DummySpawner = $DummySpawner
@onready var sub_viewport_container: SubViewportContainer = %SubViewportContainer
@onready var ghost_building_container: Node2D = %GhostBuildingContainer


func _ready() -> void:
	dummy_spawner.dummy_died.connect(_on_dummy_died)
	dummy_spawner.dummy_took_damage.connect(_on_dummy_took_damage)
	hud.turret_button_pressed.connect(_on_turret_button_pressed)

	hud.update_godocoins(godocoins_amount)
	hud.update_deaths(deaths_amount)

func _physics_process(delta: float) -> void:
	if is_in_building_mode:
		var grid_coords := availability_grid.local_to_map(get_global_mouse_position())
		var tileset_size := availability_grid.tile_set.get_tile_size()
		var global_pos := Vector2(grid_coords.x * tileset_size.x, grid_coords.y * tileset_size.y)
		sub_viewport_container.global_position = global_pos

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse_button"):
		var coords := availability_grid.local_to_map(sub_viewport_container.global_position)
		if availability_grid.get_cell_atlas_coords(coords) == AvailabilityGrid.tile_mapping.get(AvailabilityGrid.TILE_TYPE.CAN_BUILD):
			building_grid.set_cell(availability_grid.local_to_map(sub_viewport_container.global_position), 0, Vector2i.ZERO, 1)


func _on_turret_button_pressed() -> void:
	is_in_building_mode = true
	var scene := load("res://scenes/traps/shooting/turret/turret.tscn")
	var scene_object = scene.instantiate()
	scene_object.process_mode = PROCESS_MODE_DISABLED
	ghost_building_container.add_child(scene_object)
	sub_viewport_container.show()
	availability_grid.show_for(walls_grid)

func _on_dummy_took_damage(amount: int) -> void:
	godocoins_amount += amount
	hud.update_godocoins(godocoins_amount)

func _on_dummy_died() -> void:
	deaths_amount += 1
	hud.update_deaths(deaths_amount)
