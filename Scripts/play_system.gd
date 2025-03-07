#By Bernhard Obermoser 2025
#Main Playsystem
extends Node3D


@export_category("Game Components")
@export var _cue_ball : RigidBody3D
@export var _aim_container: Node3D
@export var _cue_stick : Node3D

@export_category("Cue Stick Settings")
@export var _stick_min_z : float = 0.75
@export var _stick_max_z : float = 1.40
@export var _stick_sensitivity :float = 0.01
@onready var _stick_animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	#Hiding the Mouse
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pass
	
func _process(_delta: float) -> void:
	_handle_shot_input()
	_aim_container.position = _cue_ball.position	
	
func _input(event: InputEvent) -> void:
	#Handling Mouse Movement for the Aim Container/CueStick
	var mouse_motion = event as InputEventMouseMotion
	if mouse_motion:
		_aim_container.rotation_degrees.y += mouse_motion.relative.x
		
		#Moving the Cue Stick forward/backward
		_cue_stick.position.z += mouse_motion.relative.y * _stick_sensitivity
		_cue_stick.position.z = clamp(_cue_stick.position.z, _stick_min_z,_stick_max_z )

func _handle_shot_input():
	#Shooting the ball
	if Input.is_action_just_pressed("shoot"):
		_stick_animation_player.play("shoot_stick")
		

func _shoot_ball():
	#Shooting the ball
	var stick_direction = -_aim_container.basis.z
	_cue_ball.apply_central_impulse(stick_direction)
	GameEvents.cue_ball_hit.emit()
