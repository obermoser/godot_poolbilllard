class_name RulesProcessor
extends Node

func _ready() -> void:
	GameEvents.all_balls_stopped.connect(_process_rules)

func _process_rules()->void:
	GameEvents.shot_completed.emit()
