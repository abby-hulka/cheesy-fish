extends Control

@onready var label = $Label
@onready var QrCode = $QrCode

# Called when the node enters the scene tree for the first time.
func _ready():
	# 1. Hide everything at the start
	label.modulate.a = 0.0
	label.visible_ratio = 0.0
	QrCode.modulate.a = 0.0
	
	# 2. Create Tween #1 (ONLY for the text)
	var text_tween = create_tween()
	text_tween.set_parallel(true) # Both text animations happen together
	text_tween.tween_property(label, "modulate:a", 1.0, 2.0)
	text_tween.tween_property(label, "visible_ratio", 1.0, 3.0)
	
	# 3. THE PAUSE: Tell the entire script to just stop and wait for 3.5 seconds
	await get_tree().create_timer(3.5).timeout
	
	# 4. Create Tween #2 (ONLY for the QR Code)
	# This code literally cannot run until the 3.5 seconds are up!
	var qr_tween = create_tween()
	qr_tween.tween_property(QrCode, "modulate:a", 1.0, 2.0)
