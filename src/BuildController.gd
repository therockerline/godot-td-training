extends Node

@onready var tower_instance = load("res://scenes/entity/Tower.tscn")

func _on_slot_container_on_slot_selected(slot: SlotItem):
	var tower = tower_instance.instantiate()
	slot.build_tower(tower)


