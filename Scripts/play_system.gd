#By Bernhard Obermoser 2025
#Main Playsystem
extends Node3D

@export var _cue_ball : RigidBody3D


func _process(delta: float) -> void:
	#Shooting the ball
	if Input.is_action_just_pressed("shoot"):
		var impulse_vector = Vector3(1,0,0)
		_cue_ball.apply_central_impulse(impulse_vector)
