class_name DataLabel
extends Node

@onready var _label: Label = $Datalabel/Label
@onready var _value: Label = $Datalabel/Value

func _init(label: String, initial_value: String):
	_label.text = label
	_value.text = initial_value

func set_label(l: String):
	_label.text = l + ': '

func set_value(v: String):
	_value.text = v
