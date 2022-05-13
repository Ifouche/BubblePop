extends RigidBody2D

# setget gives us "protected variables"
var type: int setget change_type;

func change_type(type_to_change:int):
	type = type_to_change;
	$Sprite.frame = type;
	
