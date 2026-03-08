extends Node


var temp = 100

@onready var score_label: Label = $ScoreLabel

func add_point(temp):
	score_label.text = str(temp) + "%"
	print(int(temp))

func sub_point(temp):
	score_label.text = str(temp) + "%"
	print(int(temp))
