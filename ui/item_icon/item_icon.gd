extends TextureButton

@export var purchasable_item: PurchasableItem

@onready var godocoins_amount_label := %GodocoinsAmountLabel
@onready var deaths_amount_label := %DeathsAmountLabel


func _ready() -> void:
	pressed.connect(_on_pressed)

	godocoins_amount_label.text = str(purchasable_item.godocoins_cost)
	deaths_amount_label.text = str(purchasable_item.death_requirement)
	tooltip_text = "%s\n%s" % [purchasable_item.item_name, purchasable_item.item_description]


func _on_pressed() -> void:
	if purchasable_item is Upgrade:
		Upgrade.upgrade_functions.get(purchasable_item.upgrade_type).call()
	elif purchasable_item is Building:
		var building := purchasable_item as Building
