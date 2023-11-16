extends Node

class_name BattleTeam


var _commands: Array

var _command_idx: int
var _latest_frame: int
var _get_enemies: Callable
var _instance_map: Dictionary
var _turn_signal: Signal

var team_code: int
var is_over: bool

func _init(team: int, commands: Array, turn_signal: Signal):
	_commands = commands
	_get_enemies = _get_enemies
	
	_command_idx = 0
	_instance_map = {}
	_latest_frame = 0
	_turn_signal = turn_signal
	
	
	team_code = team
	is_over = false

func set_func_get_enemies(get_enemies: Callable):
	_get_enemies = get_enemies
	
func set_is_over():
	is_over = true

func _get_is_over():
	return len(_commands) - 1 <= _command_idx
		
func _update_skill_history(frame):
	_latest_frame = frame
	_command_idx += 1

		
func _check_fire_skill(current_frame: int):
	var command = _commands[_command_idx]
	var food: Player = _instance_map[command.id].instance_node
	
	var skill_settings: SkillSettings = GameHelper.get_skill_settings(food, command.skill_id)
	var required_frame: int = skill_settings.frame + food.damage_frame
	
	if required_frame <= current_frame - _latest_frame :
		return true
	else:
		return false
	
func _activate_command(command, turn):
	var food: Player = _instance_map[command.id].instance_node
	var skill: Callable = GameHelper.get_skill(food, command.skill_id)
	
	skill.call(_instance_map, _get_enemies.call(), turn)
	food.remove_damage_frame()
	
func get_instance_map():
	return _instance_map
		
func _get_current_food() -> Player:
	var command = _commands[_command_idx]
	var food: Player = _instance_map[command.id].instance_node
	
	return food
	
func on_frame_changed_fire_skill(frame, turn) -> bool:
	if is_over:
		return false
	elif _get_is_over():
		set_is_over()
		return false
	
	var fire_skill = _check_fire_skill(frame)
	var food = _get_current_food()

	if fire_skill and food.stun:
		food.toggle_stun(false)
		_update_skill_history(frame)
	elif fire_skill:
		_activate_command(_commands[_command_idx], turn)
		_update_skill_history(frame)
		
	return fire_skill
		
func batch_characters(areas: Array, batchs: Array):
	for i in range(len(areas)):
		var area = areas[i]
		var characters = batchs[i]
	
		for character in characters:
			var food: Player = GameHelper.get_food_instance(character.type)
			
			_instance_map[character.id] = InstanceMap.new(i, food)
			
			food.set_team(team_code)
			food.set_id(character.id)
			area.add_child(food)
			
			_turn_signal.connect(food._on_turn_changed)

func get_team_health() -> int:
	var health = 0
	
	for key in _instance_map:
		var food: Player = _instance_map[key].instance_node
		health += food.get_health()
	
	return health
