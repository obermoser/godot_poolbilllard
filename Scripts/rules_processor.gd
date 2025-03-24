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
			
			if ball._is_object_ball():
				_check_and_set_ball_suit_for_players(ball)
				print("Ball Suits are: ",_game_state.ball_suit_by_player_id)
		pass
		
	_game_state.current_play_state = Enums.PlayState.AIMING
	GameEvents.shot_completed.emit()
	
func _check_and_set_ball_suit_for_players(ball:Ball)->void:
	var cp_id = _game_state.current_player_id
	
	if _game_state.ball_suit_by_player_id[cp_id] == Enums.BallType.TBD:
		_game_state.ball_suit_by_player_id[cp_id] = ball._ball_type
		 
		var op_id = _get_other_player_id(cp_id)
		
		var suits_remaining = [Enums.BallType.SOLIDS, Enums.BallType.STRIPES]
		suits_remaining.erase(ball._ball_type)
		
		## Assigns the ball type to the oponent
		_game_state.ball_suit_by_player_id[op_id] = suits_remaining[0]
		
## Returns the id of the other player.[br]
## Takes [param player_id] as the current player's id
func _get_other_player_id(player_id:int)->int:
	return int(not player_id)

## Fires when a ball gets into a pocket.[br]
## Gets [param ball] & [param pocket]
func _on_ball_potted(ball:Ball, pocket:Pocket):
	var pocket_occurence = PocketOccurence.new()
	pocket_occurence.ball = ball
	pocket_occurence.pocket = pocket
	_occurences_during_shot.append(pocket_occurence)


## Occurences
## Keeps track of what happened on the field
class Occurence:
	pass
	
class PocketOccurence extends Occurence:
	var ball: Ball
	var pocket: Pocket

class CushionOccurence:
	pass
