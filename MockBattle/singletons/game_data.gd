extends Node

# Actual vars for game
var defense_position = {}
var defense_command = {}
var attack_position = {}
var attack_command = {}

# Strings for Edit
var defense_position_str = {}
var defense_command_str = {}
var attack_position_str = {}
var attack_command_str = {}

# Load Gamedatas of position & command
var atk_pos_path = "res://datas/attack_position.json"
var dfn_pos_path = "res://datas/defense_position.json"
var atk_cmd_path = "res://datas/attack_command.json"
var dfn_cmd_path = "res://datas/defense_command.json"


func _ready():
	defense_position = loadjson(dfn_pos_path)
	defense_command = loadjson(dfn_cmd_path)
	attack_position = loadjson(atk_pos_path)
	attack_command = loadjson(atk_cmd_path)
	
	defense_position_str = loadstring(dfn_pos_path)
	defense_command_str = loadstring(dfn_cmd_path)
	attack_position_str = loadstring(atk_pos_path)
	attack_command_str = loadstring(atk_cmd_path)

func saveall():
	savejson(attack_position_str, atk_pos_path)
	savejson(defense_position_str, dfn_pos_path)
	savejson(attack_command_str, atk_cmd_path)
	savejson(defense_command_str, dfn_cmd_path)

func loadjson(path : String):
	if FileAccess.file_exists(path):
		var datafile = FileAccess.open(path, FileAccess.READ)
		var strings = datafile.get_as_text()
		var json = JSON.new()
		var parsed = json.parse(strings)
		if parsed == OK:
			var data_received = json.data
			if typeof(data_received) == TYPE_ARRAY:
				print("ARRAY")
				print(path)
				print(data_received)
				return data_received
			else:
				print(typeof(data_received))
				print(path)
		else:
			print("JSON Parse Error: ", json.get_error_message(), " in ", strings, "at line ", json.get_error_line())


func loadstring(path : String):
	if FileAccess.file_exists(path):
		var datafile = FileAccess.open(path, FileAccess.READ)
		var strings = datafile.get_as_text()
		return strings


		
func savejson(data : String, path : String):
	var dataFile = FileAccess.open(path, FileAccess.WRITE)
	dataFile.store_string(data)
	
	
