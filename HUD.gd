extends CanvasLayer
class_name HUD
@onready var queue_label = $Control/GridContainer/Queue
@onready var next_qeue_label = $Control/GridContainer/NextQueue
@onready var time_label = $Control/GridContainer/TimeDatalabel
@onready var total_distance_label = $Control/GridContainer/TotalDistanceDatalabel
@onready var path_label = $Control/GridContainer/PathDatalabel

func set_queue(v):
	queue_label.set_value(v)
	
func set_next_queue(v):
	next_qeue_label.set_value(v)
	
func set_total_distance(distance):
	total_distance_label.set_value(distance)
	
func set_path(path):
	path_label.set_value(path)

func set_time(v):
	time_label.set_value(v)

