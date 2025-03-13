class_name BallRack
extends Node3D

@export var _ball_tscn: PackedScene

func _ready() -> void:
	self.position = BillardTable.FOOT_SPOT
	_rack_balls()

func _rack_balls()->void:
	var ball_nums := range(1,16)
	ball_nums.shuffle()
	
	const DIAMETER = Ball.BALL_DIAMETER
	const RADIUS = Ball.BALL_RADIUS
	var ball_i = 0
	
	for i in 5:
		for j in i+1:
			var new_ball = _ball_tscn.instantiate() as Ball
			var ball_x = i*DIAMETER 
			var ball_z = (i*RADIUS) - (j*DIAMETER)
			new_ball.setup_ball(ball_nums[ball_i], ball_x, ball_z)
			self.add_child(new_ball)
			ball_i +=1
