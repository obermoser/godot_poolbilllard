extends MarginContainer
@export var _player_label: Label
@export var _instructions_label: Label
@export var _game_state:GameState

func _ready() -> void:
	GameEvents.play_state_changed.connect(_update_text)

func _update_text():
	var cp_id = _game_state.current_player_id
	
	_player_label.text = "Player " + str(cp_id +1)
	
	var player_suit = _game_state.ball_suit_by_player_id[cp_id]
	if !player_suit == Enums.BallType.TBD:
		var ball_type_as_strings = Enums.BallType.keys()
		_player_label.text += " (" + ball_type_as_strings[player_suit] + ")"
	
	var new_instructions = ""
	match _game_state.current_play_state:
		Enums.PlayState.AIMING:
			new_instructions = "Aim and shoot"
		
	_instructions_label.text = new_instructions
 
