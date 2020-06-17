extends Node

var file_content: Array = [];

var thread: Thread;
var semaphora: Semaphore;
var mutex: Mutex;

var is_loading: bool = false;
var loading_file = -1;
onready var file_bound_index = 1;

var files = [
		"res://Data/bier127.txt",
		"res://Data/pr144.txt"
	];

signal load_city(city_data);
signal loading_ended();

func _ready():
	thread = Thread.new();
	semaphora = Semaphore.new();
	mutex = Mutex.new();
	
	run_loading();
	pass

func run_loading() -> void:
	thread.start(self, "load_file", "");
	pass;

func load_file(dummy) -> void:
	while true:
		semaphora.wait();
		# loading
		if(loading_file >= 0 && loading_file <= file_bound_index):
			var file_handle = File.new();
			mutex.lock();
			
			var error = file_handle.open(files[loading_file], File.READ);
			
			if(error != OK):
				mutex.unlock();
				print("File does not exists");
				file_handle.close();
				continue;
			
			while(!file_handle.eof_reached()):
				var file_content = file_handle.get_line();
				var file_content_splited = file_content.split(" ", false);
				emit_signal("load_city", file_content_splited);
			
			emit_signal("loading_ended");	
			loading_file = -1;
			file_handle.close();
			mutex.unlock();
	
	
func begin_open(which_file) -> void:
	mutex.lock();
	loading_file = which_file;
	mutex.unlock();
	semaphora.post();
	
