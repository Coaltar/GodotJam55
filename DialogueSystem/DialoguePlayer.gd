extends Control

export (String, FILE, "json") var scene_text_file

var scene_text = {}
var selected_text = []
var in_progress = false

onready var Dialogue = $DialogueWindow/Dialogue



func _ready():
	self.hide()
	Dialogue.text = ""
	SignalBus.connect("display_dialogue", self, "on_display_dialogue")
	scene_text = load_scene_text()
	pass

func load_scene_text():
	var file = File.new()
	if file.file_exists(scene_text_file):
		file.open(scene_text_file, File.READ)
		var json_data = parse_json(file.get_as_text())
		file.close()
		return json_data

func on_display_dialogue(text_key):
	if in_progress:
		next_line()
	else:
		get_tree().paused = true
		self.show()
		in_progress = true
		selected_text = scene_text[text_key].duplicate()
		show_text()

func next_line():
	if selected_text.size() > 0:
		show_text()
	else:
		finish()

func show_text():
	var segment = selected_text.pop_front()
	var speaker = segment.keys()[0]
	var text = segment.values()[0]
	Dialogue.text = speaker + "\n\n" + text 

func finish():
	Dialogue.text = ""
	self.hide()
	get_tree().paused = false
	in_progress = false
	get_viewport().set_input_as_handled()
	
	
func _unhandled_input(event):
	if(event.is_action_pressed("interact")):
		if(in_progress):
			next_line()
			
			
