extends Node2D

signal bad_ending_triggered
signal good_ending_triggered

const DEATHS_AMOUNT_TO_WIN := 1_000_000
const BUILDINGS_SOURCE_ID := 0

var deaths_amount: int = 0:
	set(value):
		deaths_amount = value
		GameManager.deaths_amount_changed.emit(deaths_amount)
		if deaths_amount >= DEATHS_AMOUNT_TO_WIN:
			bad_ending_triggered.emit()
var godocoins_amount: int = 10:
	set(value):
		godocoins_amount = value
		GameManager.godocoins_amount_changed.emit(godocoins_amount)

var is_in_building_mode := false
var current_building_type: Building.BuildingType
var current_buying_price: int
var tile_prices: Dictionary[Vector2i, int]

@onready var hud: HUD = $Game/HUD
@onready var availability_grid: AvailabilityGrid = $Game/AvailabilityGrid
@onready var walls_grid: TileMapLayer = $Game/Walls
@onready var building_grid: TileMapLayer = $Game/BuildingGrid
@onready var dummy_spawner: DummySpawner = $Game/DummySpawner
@onready var sub_viewport_container: SubViewportContainer = %SubViewportContainer
@onready var ghost_building_container: Node2D = %GhostBuildingContainer
@onready var sell_sfx: AudioStreamPlayer = $Game/SellSFX
@onready var build_sfx: AudioStreamPlayer = $Game/BuildSFX


func _ready() -> void:
	dummy_spawner.dummy_died.connect(_on_dummy_died)
	dummy_spawner.dummy_took_damage.connect(_on_dummy_took_damage)
	GameManager.building_button_pressed.connect(_on_building_button_pressed)

	GameManager.deaths_amount_changed.emit(deaths_amount)
	GameManager.godocoins_amount_changed.emit(godocoins_amount)

func _physics_process(delta: float) -> void:
	var grid_coords := availability_grid.local_to_map(get_global_mouse_position())
	var tileset_size := availability_grid.tile_set.get_tile_size()
	var global_pos := Vector2(grid_coords.x * tileset_size.x, grid_coords.y * tileset_size.y)
	sub_viewport_container.global_position = global_pos

func _input(event: InputEvent) -> void:
	var coords := availability_grid.local_to_map(sub_viewport_container.global_position)
	if event.is_action_pressed(&"sell"):
		var tile_price = tile_prices.get(coords)
		if tile_price != null:
			building_grid.erase_cell(coords)
			availability_grid.set_cell(coords, 0, AvailabilityGrid.tile_mapping.get(AvailabilityGrid.TILE_TYPE.CAN_BUILD), 0)
			tile_prices.erase(coords)
			sell_sfx.play()
			godocoins_amount += tile_price
	elif event.is_action_pressed(&"build") and is_in_building_mode:
		if availability_grid.get_cell_atlas_coords(coords) == AvailabilityGrid.tile_mapping.get(AvailabilityGrid.TILE_TYPE.CAN_BUILD) and godocoins_amount >= current_buying_price:
			build_sfx.play()
			building_grid.set_cell(coords, BUILDINGS_SOURCE_ID, Vector2i.ZERO, current_building_type)
			availability_grid.set_cell(coords, 0, AvailabilityGrid.tile_mapping.get(AvailabilityGrid.TILE_TYPE.CANT_BUILD), 0)
			godocoins_amount -= current_buying_price
			tile_prices.set(coords, current_buying_price)
	elif event.is_action_pressed(&"exit_build") and is_in_building_mode:
		is_in_building_mode = false
		sub_viewport_container.hide()
		availability_grid.hide()


func _on_building_button_pressed(building: Building) -> void:
	is_in_building_mode = true
	current_building_type = building.building_type
	current_buying_price = building.godocoins_cost
	var scene: PackedScene = _get_scene_path_from_tilemap(current_building_type)
	var scene_object: Node = scene.instantiate()
	scene_object.process_mode = PROCESS_MODE_DISABLED
	ghost_building_container.add_child(scene_object)
	sub_viewport_container.show()
	availability_grid.show_for(walls_grid, building_grid)

func _get_scene_path_from_tilemap(building_type: Building.BuildingType) -> PackedScene:
	var tile_set_source: TileSetScenesCollectionSource = building_grid.tile_set.get_source(BUILDINGS_SOURCE_ID)
	return tile_set_source.get_scene_tile_scene(building_type)

func _on_dummy_took_damage(amount: int) -> void:
	godocoins_amount += amount

func _on_dummy_died() -> void:
	deaths_amount += 1
