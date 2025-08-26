class_name Building
extends PurchasableItem

# Order of elements must correspond to order of scenes in BuildingGrid tile map layer in the main scene.
enum BuildingType {
	TURRET,
	MACHINE_GUN,
}

@export var building_type: BuildingType
