extends Node2D

onready var Bubbles = $TileMap;

const MAP_X = 18;
const MAP_Y = 15;

export (int,2,10) var number_of_bubble_types = 4;

func _ready():
	randomize();
	for y in floor(MAP_Y/2) :
		for x in MAP_X:
			var bubble_type = randi() % number_of_bubble_types;
			Bubbles.set_cell(x,y,bubble_type)
