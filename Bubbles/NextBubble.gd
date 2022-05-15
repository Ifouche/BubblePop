extends Node2D

signal next_bubble;

func _ready():
	randomize();

func prepare_bubble(available_bubbles: Array):
	var type = available_bubbles[randi() % available_bubbles.size()];
	$Sprite.frame = type;
	emit_signal("next_bubble", type);
