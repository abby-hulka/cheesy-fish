extends Node


var temp = 100

@onready var cold_label: Label = $CanvasLayer/TextureRect/cold_label

func add_point(temp):
	cold_label.text = str(int(temp)) + "%"


func sub_point(temp):
	cold_label.text = str(int(temp)) + "%"
