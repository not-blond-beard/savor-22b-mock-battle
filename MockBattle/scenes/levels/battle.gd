extends Node2D

var _game_turn: int = 0

var defense_team: BattleTeam
var attack_team: BattleTeam

var frame_counter: FrameCounter

signal game_turn_changed(current_turn)

func _ready():
	var command_setting = Settings.get_command_settings()
	defense_team = BattleTeam.new(Settings.DEFENSE_TEAM_CODE, command_setting["defense"], game_turn_changed)
	attack_team = BattleTeam.new(Settings.ATTACK_TEAM_CODE, command_setting["attack"], game_turn_changed)
	
	defense_team.set_func_get_enemies(attack_team.get_instance_map)
	attack_team.set_func_get_enemies(defense_team.get_instance_map)
	
	frame_counter = FrameCounter.new()
	
	add_child(frame_counter)
	
	frame_counter.frame_changed.connect(_on_frame_changed)
	frame_counter.frame_changed.connect(_update_frame_text)
	frame_counter.start_frame()
	
	batch_characters_at_areas()

func get_game_turn() -> int:
	return _game_turn
	
func _set_turn_text(turn: int):
	var text = $main_panel/turn
	
	text.text = str(turn) + "턴"
	
func set_turn(turn: int):
	_game_turn = turn
	_set_turn_text(turn)
	
	game_turn_changed.emit(_game_turn)
	
func increase_game_turn():
	set_turn(_game_turn + 1)
	
func _on_change_scene_pressed():
	return get_tree().change_scene_to_file("res://scenes/levels/settings.tscn")

func show_winner():
	var code = get_winner_team_code()
	var winner_alert: WinnerAlert = $winner_alert
	
	winner_alert.show_winner(code)

func check_game_end() -> bool:
	if defense_team.is_over and attack_team.is_over:
		show_winner()
		return true
		
	return false

func _update_frame_text(frame: int):
	var text = $main_panel/frame
	
	text.text = str(frame)
	
func _on_frame_changed(frame):
	if check_game_end():
		frame_counter.stop_frame()
		return
		
	var defense_fire_skill: bool = defense_team.on_frame_changed_fire_skill(frame, get_game_turn())
	var attack_fire_skill: bool = attack_team.on_frame_changed_fire_skill(frame, get_game_turn())
	
	if defense_fire_skill or attack_fire_skill:
		increase_game_turn()
		frame_counter.pause_frame()
		
	if defense_fire_skill:
		defense_team.clear_guard()
	
	if attack_fire_skill:
		attack_team.clear_guard()
	
func batch_characters_at_areas():
	var defnse_front_area = $defense_panel/front
	var defnse_center_area = $defense_panel/center
	var defnse_back_area = $defense_panel/back
	
	var attack_front_area = $attack_panel/front
	var attack_center_area = $attack_panel/center
	var attack_back_area = $attack_panel/back
	
	var batch_setting = Settings.get_batch_setting()
	defense_team.batch_characters([defnse_front_area, defnse_center_area, defnse_back_area], batch_setting["defense"], false)
	attack_team.batch_characters([attack_front_area, attack_center_area, attack_back_area], batch_setting["attack"], true)
	

func get_winner_team_code() -> int:
	var defense_team_total_health: int = defense_team.get_team_health()
	var attack_team_total_healath: int = attack_team.get_team_health()
			
	if defense_team_total_health > attack_team_total_healath:
		return Settings.DEFENSE_TEAM_CODE
	elif defense_team_total_health < attack_team_total_healath:
		return Settings.ATTACK_TEAM_CODE
	else:
		return 0
