class_name DummyBodyPart
extends RigidBody2D

func hit(amount: int) -> void:
	(get_parent() as Dummy).hit(amount)