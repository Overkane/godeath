extends TextureButton

@export var purchasable_item: PurchasableItem

@onready var godocoins_amount_label := %GodocoinsAmountLabel
@onready var deaths_amount_label := %DeathsAmountLabel


func _ready() -> void:
	GameManager.deaths_amount_changed.connect(_update_availability)
	pressed.connect(_on_pressed)

	godocoins_amount_label.text = str(purchasable_item.godocoins_cost)
	deaths_amount_label.text = str(purchasable_item.death_requirement)
	tooltip_text = "%s\n%s" % [purchasable_item.item_name, purchasable_item.item_description]

	disabled = true

func _on_pressed() -> void:
	if purchasable_item is Upgrade:
		disabled = true
		Upgrade.upgrade_functions.get(purchasable_item.upgrade_type).call()
	elif purchasable_item is Building:
		GameManager.building_button_pressed.emit(purchasable_item)

func _update_availability(amount: int) -> void:
	if purchasable_item.death_requirement <= amount:
		disabled = false
		GameManager.deaths_amount_changed.disconnect(_update_availability)
