extends Control

@onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.modulate.a = 0.0 #transparency
	label.visible_ratio = 0.0
	
	var tween = create_tween()
	# tween.set_parallel(true) #happens at exact same time
	
	tween.tween_property(label, "modulate:a", 1.0, 2.0)
	tween.tween_property(label, "visible_ratio", 1.0, 1.0) #typewriter 100% (first 1.0) over 1 second (2nd 1.0)
	
