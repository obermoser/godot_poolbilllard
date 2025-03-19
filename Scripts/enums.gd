extends Node

## Gives the right colors to the balls according to its value
enum BallType{
	## Solid colors, from 1-8
	SOLIDS,
	STRIPES,
	CUE_BALL,
	EIGHT_BALL,
	TBD
}
 
enum PlayState { ## Handling the play state of the balls
	## The Player is just aiming
	AIMING,
	## The shot was already fired and balls are rollin
	BALLS_IN_PLAY,
}
