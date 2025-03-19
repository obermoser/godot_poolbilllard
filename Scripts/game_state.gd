class_name GameState
extends Resource

@export var current_player_id: int
@export var current_play_state: Enums.PlayState:
	set(new_playstate):
		current_play_state = new_playstate
		GameEvents.play_state_changed.emit()

@export var ball_suit_by_player_id: Array[Enums.BallType]
