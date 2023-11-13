extends Node2D

var frame: int = 0
var frame_disabled: bool = true

@export var skill_pause_frame_second: int = 1

signal frame_changed(new_frame)

func _set_frame(_frame: int):
	frame = _frame
	
	frame_changed.emit(_frame)
	
func start_frame():
	frame_disabled = false
	
func stop_frame():
	frame_disabled = true
	
func pause_frame():
	stop_frame()

	await get_tree().create_timer(skill_pause_frame_second).timeout
	
	start_frame()
	

func _process(delta):
	if !frame_disabled:
		_set_frame(frame + 1)
