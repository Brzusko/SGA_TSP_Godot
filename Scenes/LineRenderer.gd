extends Node2D

var member_ref;
var can_draw = false;
# Called when the node enters the scene tree for the first time.
func _ready():
	member_ref = get_parent();
	
	if(member_ref.get_class() != "Node2D"):
		push_error("Missing member reference");
		get_tree().quit();
	pass # Replace with function body.

func _process(delta):
	update();
	return delta;

func _draw():
	if(can_draw):
		for route in member_ref.routes:
			draw_line(route.from.position, route.to.position, Color.red, 10.0);
			draw_circle(route.from.position, 10.0, Color.blue);
			pass;
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
