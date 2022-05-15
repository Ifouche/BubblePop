extends Node2D

var Bubble = preload("res://Bubbles/Bubble.tscn");

onready var Bubbles = $TileMap;
onready var BubbleSpawner = $BubbleSpawner;
onready var Player = $Player;
onready var NextBubble = $NextBubble;

var PlayerLocation:Vector2;

const MAP_X = 18;
const MAP_Y = 15;

export (int,2,10) var number_of_bubble_types = 4;

func _ready():
	randomize();
	PlayerLocation = Player.global_position;
	print(PlayerLocation)
	set_bubbles();
	check_remaining_bubbles();
	
func set_bubbles():
	for y in floor(MAP_Y/2) :
		for x in MAP_X:
			var bubble_type = randi() % number_of_bubble_types;
			Bubbles.set_cell(x,y,bubble_type);


func _on_Player_fire_bubble(angle):
	BubbleSpawner.spawn_bubble(angle, PlayerLocation);
	check_remaining_bubbles();
	
func check_remaining_bubbles():
	var available_bubbles = [];
	for bubble in number_of_bubble_types:
		available_bubbles.append(bubble);
		
	NextBubble.prepare_bubble(available_bubbles);

func set_bubble(bubble: Bubble):
	var pos = Bubbles.world_to_map(bubble.global_position);
	Bubbles.set_cell(pos.x, pos.y, bubble.type);
	bubble.queue_free();
