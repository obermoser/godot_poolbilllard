extends Node

## Dependency Injection
@export var _game_state: GameState

func _ready() -> void:
	GameEvents.all_balls_stopped.connect(_process_rules)

func _process_rules()->void:
	_game_state.current_play_state = Enums.PlayState.AIMING
	GameEvents.shot_completed.emit()
