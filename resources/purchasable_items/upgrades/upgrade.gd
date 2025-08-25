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
	UpgradeType.ADD_DUMMY1: add_dummy,
	UpgradeType.ADD_DUMMY2: add_dummy,
	UpgradeType.UPGRADE_DUMMY1: upgrade_dummy_1,
	UpgradeType.UPGRADE_DUMMY2: upgrade_dummy_2,
	UpgradeType.UPGRADE_DUMMY3: upgrade_dummy_3,
	UpgradeType.REDUCE_DUMMY_SPAWN_CD1: reduce_dummy_spawn_cd,
	UpgradeType.REDUCE_DUMMY_SPAWN_CD2: reduce_dummy_spawn_cd,
	UpgradeType.REDUCE_DUMMY_SPAWN_CD3: reduce_dummy_spawn_cd,
}

static func add_dummy():
	GameManager.dummy_upgrade_learnt.emit()

static func reduce_dummy_spawn_cd():
	DummySpawner.dummy_respawn_time -= 0.75

static func upgrade_dummy_1():
	DummyHealth.max_health += 10

static func upgrade_dummy_2():
	DummyHealth.max_health += 20

static func upgrade_dummy_3():
	DummyHealth.max_health += 30
