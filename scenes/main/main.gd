extends Node2D

signal game_won

const DEATHS_AMOUNT_TO_WIN: int = 1_000_000

var deaths_amount: int    = 0:
	set(value):
		deaths_amount = value
		if deaths_amount >= DEATHS_AMOUNT_TO_WIN:
			game_won.emit()

var godocoins_amount: int = 1

@onready var hud: HUD = $HUD
@onready var availability_grid: AvailabilityGrid = $AvailabilityGrid
@onready var walls_grid: TileMapLayer = $Walls
@onready var dummy_spawner: DummySpawner = $DummySpawner


func _ready() -> void:
	dummy_spawner.dummy_died.connect(_on_dummy_died)
	dummy_spawner.dummy_took_damage.connect(_on_dummy_took_damage)
	hud.turret_button_pressed.connect(_on_turret_button_pressed)

	hud.update_godocoins(godocoins_amount)
	hud.update_deaths(deaths_amount)


func _on_turret_button_pressed() -> void:
	availability_grid.show_for(walls_grid)


func _on_dummy_took_damage(amount: int) -> void:
	godocoins_amount += amount
	hud.update_godocoins(godocoins_amount)


func _on_dummy_died() -> void:
	deaths_amount += 1
	hud.update_deaths(deaths_amount)
