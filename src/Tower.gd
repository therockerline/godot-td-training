class_name Tower
extends Node2D
@onready var image: Sprite2D = $Image
@onready var area: CollisionShape2D = $TargetArea/CollisionShape2D
@onready var ray_container: Node2D = $RayContainer

var ray_dictionary: Dictionary = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_target_area_body_entered(body):
	print(body)
	#ray_dictionary[]
	pass # Replace with function body.


func _on_target_area_body_exited(body):
	print(body)
	pass # Replace with function body.
