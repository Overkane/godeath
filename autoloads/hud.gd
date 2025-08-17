extends CanvasLayer

@onready var godocoins_amount_label := %GodocoinsAmountLabel
@onready var deaths_amount_label := %DeathsAmountLabel


func update_deaths(amount: int) -> void:
	godocoins_amount_label.text = str(amount)

func update_godocoins(amount: int) -> void:
	deaths_amount_label.text = str(amount)
