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
	var is_last = len(_commands) - 1 <= _command_idx
	
	return is_last
		
		
func _update_skill_history(frame):
	_latest_frame = frame
	_command_idx += 1
		
func _check_fire_skill(current_frame: int, command, food):
	var skill_settings: SkillSettings = GameHelper.get_skill_settings(food, command.skill_id)
	var required_frame: int = skill_settings.frame + food.damage_frame
	
	if required_frame <= current_frame - _latest_frame :
		return true
	else:
		return false
	
func _activate_command(command: Dictionary, turn):
	var food: Player = _instance_map[command.id].instance_node
	var skill: Callable = GameHelper.get_skill(food, command.skill_id)
	
	skill.call(_instance_map, _get_enemies.call(), turn, command.get("meta", null))
	food.remove_damage_frame()
	
func get_instance_map():
	return _instance_map
	
func clear_guard():
	if _command_idx > 0:
		var command = _commands[_command_idx - 1]
		var food: Player = _instance_map[command.id].instance_node
	
		food.active_guard()
	
func on_frame_changed_fire_skill(frame, turn):
	if is_over:
		return false
		
	var command = _commands[_command_idx]
	var food: Player = _instance_map[command.id].instance_node
	
	var fire_skill = _check_fire_skill(frame, command, food)
	
	if _get_is_over() and fire_skill:
		set_is_over()
		
	if !food.guard_disabled:
		food.deactive_guard()
		
	if fire_skill and food.stun:
		food.toggle_stun(false)
		_update_skill_history(frame)
	elif fire_skill:
		_activate_command(_commands[_command_idx], turn)
		_update_skill_history(frame)
		
		
	return fire_skill

func batch_characters(areas: Array, batches: Array, flip: bool):
	var spacing = 134
	for i in range(len(areas)):
		var area = areas[i]
		var characters = batches[i]
		var current_y_position = 0

		for character in characters:
			var food: Player = GameHelper.get_food_instance(character.type)
			_instance_map[character.id] = InstanceMap.new(i, food)
			
			food.set_team(team_code)
			food.set_id(character.id)
			area.add_child(food)
			_turn_signal.connect(food._on_turn_changed)

			food.position.x = 0
			food.position.y = current_y_position
			
			if flip:
				var animated_sprite = food.get_node("AnimatedSprite2D")
				animated_sprite.flip_h = true
			
			current_y_position += spacing


func get_team_health() -> int:
	var health = 0
	
	for key in _instance_map:
		var food: Player = _instance_map[key].instance_node
		health += food.get_health()
	
	return health
