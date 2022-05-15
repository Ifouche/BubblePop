extends Node2D

var Bubble = preload("res://Bubbles/Bubble.tscn");
var next_bubble_type = 0;

const BUBBLE_SPEED: int = 500;

func _ready():
	pass

func spawn_bubble(angle:float, Location:Vector2):
	var fire_Bubble = Bubble.instance();
	fire_Bubble.global_position = Location;
	fire_Bubble.type = next_bubble_type;
	add_child(fire_Bubble);
	fire_Bubble.apply_central_impulse(-Vector2(0,1).rotated(angle) * BUBBLE_SPEED);
	fire_Bubble.connect("bubble_stopped", get_parent(), "set_bubble");


func _on_NextBubble_next_bubble(type):
	next_bubble_type = type;
