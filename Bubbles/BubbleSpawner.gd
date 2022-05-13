extends Node2D

var Bubble = preload("res://Bubbles/Bubble.tscn");

const BUBBLE_SPEED: int = 500;

func _ready():
	pass

func spawn_bubble(angle:float, Location:Vector2):
	var fire_Bubble = Bubble.instance();
	fire_Bubble.global_position = Location;
	add_child(fire_Bubble);
	fire_Bubble.apply_central_impulse(-Vector2(0,1).rotated(angle) * BUBBLE_SPEED);
