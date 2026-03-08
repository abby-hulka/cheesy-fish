extends Area2D

@onready var white_screen = $CanvasLayer/ColorRect
@onready var win_label = $CanvasLayer/ColorRect/Label
@onready var QrCode = $CanvasLayer/ColorRect/QrCode

#Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Hide the white screen and reset the text at the very start of the level
	white_screen.modulate.a = 0.0
	win_label.visible_ratio = 0.0
	QrCode.modulate.a = 0.0

func _on_body_entered(body: Node2D) -> void:
	if "is_dead" in body:
		body.is_dead = true
		body.velocity = Vector2.ZERO
		#body.set_physics_process(false)
		body.set_process_input(false)
		body.animated_sprite.play("idle")

		var tween = create_tween() #tween animator

		tween.tween_property(white_screen, "modulate:a", 1.0, 2.0)
		tween.parallel().tween_property(win_label, "visible_ratio", 1.0, 4.0)
		tween.parallel().tween_property(QrCode, "modulate:a", 1.0, 2.0)
