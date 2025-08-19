class_name HUD
extends CanvasLayer

signal turret_button_pressed

@onready var godocoins_amount_label := %GodocoinsAmountLabel
@onready var deaths_amount_label := %DeathsAmountLabel
#@onready var turret_button := %TurretButton


func _ready() -> void:
	pass
	#turret_button.pressed.connect(func(): turret_button_pressed.emit())


func update_deaths(amount: int) -> void:
	godocoins_amount_label.text = str(amount)

func update_godocoins(amount: int) -> void:
	deaths_amount_label.text = str(amount)
