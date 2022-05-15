extends RigidBody2D
class_name Bubble

signal bubble_stopped;

# setget gives us "protected variables"
var type: int setget change_type;

const WALL_LAYER = 1;

func change_type(type_to_change:int):
	type = type_to_change;
	$Sprite.frame = type;
	


func _on_Bubble_body_entered(body):
	if body.collision_layer != WALL_LAYER:
		lock_bubble();
		
func lock_bubble():
	emit_signal("bubble_stopped", self);
