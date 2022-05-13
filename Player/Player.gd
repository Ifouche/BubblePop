extends Node2D

const MAX_ANGLE:int = 70;
const MOVEMENT_SPEED:int = 1; 

var animations = ["look", "blink", "flap"];


func _ready():
	randomize();
	
func _process(_delta):
	var input = Input.get_action_strength("Right") - Input.get_action_strength("Left");
	rotate_cannon(input)

func _unhandled_input(event):
	if event.is_action_pressed("Nudge Left"):
		rotate_cannon(-1.0);
	if event.is_action_pressed("Nudge Right"):
		rotate_cannon(1.0);
	if event.is_action_pressed("Fire"):
		print("FIRE");

func _on_AnimationTimer_timeout():
	if $Tucan.animation == "idle":
		$Tucan.play(animations[randi() % 3]);


func _on_Tucan_animation_finished():
	$Tucan.play("idle");

func rotate_cannon(input:float) :
	var rotation = $Aimer.rotation_degrees + input * MOVEMENT_SPEED;
	if abs(rotation) < MAX_ANGLE:
		$Aimer.rotation_degrees = rotation;
