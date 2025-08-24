class_name Upgrade
extends PurchasableItem

enum UpgradeType {
	ADD_DUMMY1,
	ADD_DUMMY2,
	UPGRADE_DUMMY1,
	UPGRADE_DUMMY2,
	UPGRADE_DUMMY3,
	REDUCE_DUMMY_SPAWN_CD1,
	REDUCE_DUMMY_SPAWN_CD2,
	REDUCE_DUMMY_SPAWN_CD3,
}

@export var upgrade_type: UpgradeType

static var upgrade_functions: Dictionary[UpgradeType, Callable] = {
	UpgradeType.ADD_DUMMY1: add_dummy_1,
	UpgradeType.ADD_DUMMY2: add_dummy_2,
}


static func add_dummy_1():
	print("1")

static func add_dummy_2():
	print("2")
