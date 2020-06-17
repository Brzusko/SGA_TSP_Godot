extends Node2D

class_name City

var id: int = 0;
var x: float = 0;
var y: float = 0;

var is_parent = false;

var color: Array = [
	
	Color.red,
	Color.rosybrown,
	Color.wheat,
	Color.brown,
	Color.blue,
	Color.blueviolet,
	Color.white
	
];

var current_color = color[0];

func _ready():
	var rng = RandomNumberGenerator.new();
	rng.randomize();
	var index = rng.randi_range(0, color.size() - 1);
	current_color = color[index];
	pass # Replace with function body.
	
func _process(delta):
	update();
	return delta;

func setup(data: Dictionary, is_parent_arg: bool = false) -> void:
	var pos = Vector2(data.x / 10, data.y / 10);
	x = data.x / 10;
	y = data.y / 10;
	id = data.id;
	name = "City: " + str(id);
	global_position = pos;
	self.is_parent = is_parent_arg;

func get_city_data() -> Dictionary:
	var city_data = {
		"position": get_global_transform().get_origin(),
		"id": self.id
	}
	return city_data;
	
func _draw():
	draw_circle(global_position, 40.0, current_color);
