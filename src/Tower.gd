class_name Tower
extends Node2D

enum TowerTypes {
	AREA,
	SHOOTER
}

@export var damage := 1.0
@onready var image: Sprite2D = $Image
@onready var area: CollisionShape2D = $TargetArea/CollisionShape2D
@onready var ray_container: Node2D = $RayContainer
@onready var fire_timer: Timer = $FireTimer
@onready var tower_ray_target_prop = load("res://scenes/entity/TowerRayTraget.tscn")
var ray_dictionary: Dictionary = {}
var tower_type: TowerTypes = TowerTypes.SHOOTER

var near = {}
var far = {}
var first = {}
var last = {}
var strong = {}
var weak = {}

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
	var ray_item = ray_dictionary[enemy.name]
	if ray_item == near:
		near = {}
	if ray_item == near:
		far = {}
	if ray_item == first:
		first = {}
	if ray_item == last:
		last = {}
	if ray_item == strong:
		strong = {}
	if ray_item == weak:
		weak = {}
	ray_item.ray.queue_free()
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

func reset_or_set_modulate(a: Dictionary, b: Dictionary, modulate: Color):
	if a.has('ray'):
		if a != b and is_instance_valid(a.ray):
			a.ray.modulate = Color.WHITE
		if b.has('ray') and is_instance_valid(b.ray):
			b.ray.modulate = modulate
	return b

func _on_fire_timer_timeout():
	var _near: Dictionary = near
	var _far: Dictionary = far
	var _strong: Dictionary = strong
	var _weak: Dictionary = weak
	var _first: Dictionary = ray_dictionary.values().front()
	var _last: Dictionary = ray_dictionary.values().back()
	var ray_len = len(ray_dictionary.keys())
	for ray_item in ray_dictionary.values():
		var enemy: Enemy = ray_item.enemy
		if is_instance_valid(enemy):
			_far = ray_item if (not _far.has('enemy') or (is_instance_valid(_far.enemy) and position.distance_to(_far.enemy.position) < position.distance_to(enemy.position))) else _far
			_near = ray_item if (not _near.has('enemy') or (is_instance_valid(_near.enemy) and position.distance_to(_near.enemy.position) >= position.distance_to(enemy.position))) else _near
			_strong = ray_item if (not _strong.has('enemy') or (is_instance_valid(_strong.enemy) and (_strong.enemy as Enemy).life > enemy.life)) else _strong
			_weak = ray_item if (not _weak.has('enemy') or (is_instance_valid(_weak.enemy) and (_weak.enemy as Enemy).life <= enemy.life)) else _weak
	
	near = reset_or_set_modulate(near, _near, Color.BLUE)
	far = reset_or_set_modulate(far, _far, Color.GREEN)
	first = reset_or_set_modulate(first, _first, Color.RED)
	last = reset_or_set_modulate(last, _last, Color.WEB_PURPLE)
	strong = reset_or_set_modulate(strong, _strong, Color.YELLOW)
	weak = reset_or_set_modulate(weak, _weak, Color.GRAY)
	
	if strong.has('enemy'):
		(strong.enemy as Enemy).shot(damage)
	pass # Replace with function body.
