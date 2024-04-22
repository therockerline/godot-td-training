extends Node

@export var label: String
@export var initial_value: String

func _ready():
	$Label.text = label
	$Value.text = initial_value

func set_label(l):
	$Label.text = str(l) + ': '

func set_value(v):
	$Value.text = str(v)
