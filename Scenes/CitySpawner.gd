extends Node

class_name CitySpawner

onready var CityLoader = get_node("/root/CityLoader");
onready var CityScene = preload("res://Scenes/City.tscn");
onready var label_ref = $UI/ButtonContainer/MainContainer/Separator/CitiesCounter;
var city_nodes: Array = [];
var toogle = false;

func _ready():
	CityLoader.connect("load_city", self, "on_load");
	CityLoader.connect("loading_ended", self, "on_loading_ended");
	pass # Replace with function body.

func destroy_all() -> void:
	for city in city_nodes:
		city.queue_free();
	city_nodes.clear();
	label_ref.text = "Loaded cities: 0";
	
func on_load(data: Array) -> void:
	var city_data = {
		"id": int(data[0]),
		"x": float(data[1]),
		"y": float(data[2])
	};
	
	var city_node = CityScene.instance();
	add_child(city_node);
	
	var is_parent = false if city_data.id > 1 else true;
	city_node.setup(city_data, is_parent);
	city_nodes.append(city_node);

	label_ref.text = "Loaded cities: " + str(city_nodes.size());
	pass;
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func on_loading_ended():
	$Member.generate_routes(city_nodes);
	pass;

func _on_Spawn_pressed():
	var which_city = -1;
	
	which_city = 0 if toogle == false else 1;

	CityLoader.begin_open(which_city);


func _on_Despawn_pressed():
	destroy_all();


func _on_WhichCities_toggled(button_pressed):
	toogle = button_pressed;
