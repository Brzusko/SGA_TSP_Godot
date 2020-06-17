extends Node

class_name Member

var thread: Thread;
var semaphora: Semaphore;

var routes: Array = [];

var route_info: Dictionary = {
	"from": 0, # City object info
	"to": 0, # City object info 
	"distance": Vector2.ZERO
};

func _ready():
	print($LineRenderer.position);
	pass # Replace with function body.
	
func generate_routes(cities: Array) -> void:
	var array_size = cities.size() - 1;
	var fixed_size = array_size - 1;
	for i in range(array_size):
		var route = {
		};
		match i:
			fixed_size:
				route["from"] = cities[i].get_city_data();
				route["to"] = cities[0].get_city_data();
				route["distance"] = route.to.position - route.from.position;
			_:
				route["from"] = cities[i].get_city_data();
				route["to"] = cities[i + 1].get_city_data();
				route["distance"] = route.to.position - route.from.position;
		routes.append(route);
	$LineRenderer.can_draw = true;
	
func shift_routes() -> void:
	pass;

func mutate() -> void:
	pass;
