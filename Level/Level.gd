extends Node2D

var Bubble = preload("res://Bubbles/Bubble.tscn");

onready var Bubbles = $TileMap;
onready var BubbleSpawner = $BubbleSpawner;
onready var Player = $Player;
onready var NextBubble = $NextBubble;

var PlayerLocation:Vector2;
var checked_bubbles = [];
var matching_bubbles = [];

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
	matching_bubbles = [pos];
	checked_bubbles = [];
	$RemovalTimer.start();
	check_for_removal(pos);
		
func check_for_removal(pos):
	checked_bubbles.append(pos);
	var neighbors = get_neighbors(pos);
	for n in neighbors:
		if not checked_bubbles.has(pos+n) && Bubbles.get_used_cells().has(pos+n):
			if Bubbles.get_cellv(pos) == Bubbles.get_cellv(pos+n):
				matching_bubbles.append(pos+n);
				check_for_removal(pos+n);

func get_neighbors(pos):
	if int(pos.y) % 2:
		return [
			Vector2(0,-1),Vector2(1,-1),
			Vector2(-1,0),Vector2(1,0),
			Vector2(0,1),Vector2(1,1)
		];
	return [
		Vector2(1,0),Vector2(-1,0),
		Vector2(-1,-1),Vector2(0,-1),
		Vector2(-1,1),Vector2(0,1)
	];

func _on_RemovalTimer_timeout():
	if matching_bubbles.size() > 2:
		for bubble in matching_bubbles:
			Bubbles.set_cellv(bubble, -1);
