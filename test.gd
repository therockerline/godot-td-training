extends Node2D

@onready var prop = preload("res://Slot.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	var inst = prop.instantiate()
	inst.position = Vector2(200,200)
	add_child(inst)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
