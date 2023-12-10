extends Node2D

@onready var _animated_sprite = $AnimatedSprite2D

func _ready():
	_animated_sprite.connect("animation_finished", _on_animation_finished)

func _on_animation_finished():
	queue_free()
