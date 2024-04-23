class_name Tower
extends Node2D



@onready var image: Sprite2D = $Image
@onready var area: CollisionShape2D = $TargetArea/CollisionShape2D
@onready var ray_container: Node2D = $RayContainer
@onready var fire_timer: Timer = $FireTimer
@onready var tower_ray_target_prop= load("res://scenes/entity/TowerRayTraget.tscn") 
var ray_dictionary: Dictionary = {}
var tower_type: Enums.TowerTypes = 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_enemy(area):
	var enemy: Enemy = area.get_parent()
	return enemy

func create_ray(enemy: Enemy):
	var ray = tower_ray_target_prop.instantiate()
	ray_dictionary[enemy.name] = {
		"ray": ray,
		"enemy": enemy
	}
	ray_container.add_child(ray)
	ray.follow(enemy)
	if len(ray_dictionary.values()) > 0 and fire_timer.is_stopped():
		fire_timer.start()

func remove_ray(enemy: Enemy):
	ray_dictionary[enemy.name]['ray'].queue_free()
	ray_dictionary.erase(enemy.name)
	if len(ray_dictionary.values()) == 0 and not fire_timer.is_stopped():
		fire_timer.stop()
		
func _on_target_area_area_entered(area):
	var enemy = get_enemy(area)
	create_ray(enemy)
	pass # Replace with function body.


func _on_target_area_area_exited(area):	
	var enemy = get_enemy(area)
	remove_ray(enemy)
	pass # Replace with function body.

func _on_fire_timer_timeout():
	
	print('fire')
	pass # Replace with function body.
