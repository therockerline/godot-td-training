class_name Enemy
extends Node2D

signal death

@onready var enemy_body: PackedScene = load("res://scenes/entity/EnemyBody.tscn")
@export var path: Path2D
@export var speed: float = 10.0
@export var max_life = 5.0
@export var life = 5.0

@export var sprite: AnimatedSprite2D
var follower := PathFollow2D.new()
var body: EnemyBody
var _path := Path2D.new()	

func _ready():
	body = enemy_body.instantiate()
	body.enemy = self
	follower.add_child(body)
	_path = path
	_path.add_child(follower)
	add_child(_path)
	print(_path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(d):
	if follower != null and _path.curve.get_baked_length() > 1:
		var totalDistance = _path.curve.get_baked_length()
		var ratio_at_second = speed / totalDistance
		var delta_ratio_at_second = ratio_at_second * d
		follower.progress_ratio += delta_ratio_at_second
		if follower.progress_ratio == 1.0:
			queue_free()

func get_enemy_position():
	return follower.position
func get_enemy_global_position():
	return follower.global_position

func shot(dmg: float):
	var l = life - dmg
	life = l if l > 0.0 else 0.0
	body.draw_life(life, max_life)	
	if life == 0.0:
		queue_free()
		death.emit()
