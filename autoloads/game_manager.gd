extends Node

signal game_won

const DEATHS_AMOUNT_TO_WIN: int = 1_000_000

var deaths_amount: int = 0:
	set(value):
		deaths_amount = value
		if deaths_amount >= DEATHS_AMOUNT_TO_WIN:
			game_won.emit()
var godocoins_amount: int = 1
var dummy_respawn_time: float = 3.0
var dummy: Dummy


func _ready() -> void:
	HUD.update_godocoins(godocoins_amount)	
	HUD.update_deaths(deaths_amount)