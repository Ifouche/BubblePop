extends TileSet

signal reset_is_checked;

var is_checked = false;

func _ready():
	connect("rest_is_checked", get_node("res://Level/Level.tscn"
	))
	print("Bubble Ready")


