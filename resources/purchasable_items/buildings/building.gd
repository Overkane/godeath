class_name Building
extends PurchasableItem

# Order of elements must correspond to order of scenes in BuildingGrid tile map layer in the main scene.
enum BuildingType {
	TURRET,
	SPIKES,
}

@export var building_type: BuildingType
