extends Node

## Dependency Injection
@export var _game_state: GameState

var _occurences_during_shot:Array[Occurence]

func _ready() -> void:
	GameEvents.all_balls_stopped.connect(_process_rules)
	GameEvents.ball_potted.connect(_on_ball_potted)


func _process_rules()->void:
	for occ in _occurences_during_shot:
		if occ is PocketOccurence:
			var ball:Ball = occ.ball
				
		pass
		
	_game_state.current_play_state = Enums.PlayState.AIMING
	GameEvents.shot_completed.emit()
	

func _on_ball_potted(ball:Ball, pocket:Pocket):
	var pocket_occurence = PocketOccurence.new()
	pocket_occurence.ball = ball
	pocket_occurence.pocket = pocket
	_occurences_during_shot.append(pocket_occurence)

## Keeps track of what happened on the field
class Occurence:
	pass
	
class PocketOccurence extends Occurence:
	var ball: Ball
	var pocket: Pocket

class CushionOccurence:
	pass
