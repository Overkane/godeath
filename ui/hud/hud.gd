class_name HUD
extends CanvasLayer

@onready var godocoins_amount_label := %GodocoinsAmountLabel
@onready var deaths_amount_label := %DeathsAmountLabel


func _ready() -> void:
	GameManager.deaths_amount_changed.connect(_update_deaths)
	GameManager.godocoins_amount_changed.connect(_update_godocoins)


func _update_deaths(amount: int) -> void:
	deaths_amount_label.text = str(amount)

func _update_godocoins(amount: int) -> void:
	godocoins_amount_label.text = str(amount)
