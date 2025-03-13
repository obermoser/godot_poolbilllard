#By Bernhard Obermoser 2025
#Main Playsystem
extends Node3D


@export_category("Game Components")
@export var _cue_ball : RigidBody3D
@export var _aim_container: Node3D
@export var _cue_stick : Node3D

@export_category("Cue Stick Settings")
@export var _stick_min_z := 0.75
@export var _stick_max_z := 1.40
@export var _stick_sensitivity := 0.01
@onready var _stick_animation_player: AnimationPlayer = $AnimationPlayer
@export_subgroup("Shot Power")
@export var _shot_power_min := 0.5
@export var _shot_power_max := 5.0

var _shot_percent:float = 0.0


func _ready() -> void:
	#Hiding the Mouse
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	_cue_ball.position = BillardTable.HEAD_SPOT
		
func _process(_delta: float) -> void:
	_handle_shot_input()
	_aim_container.position = _cue_ball.position	
	
func _input(event: InputEvent) -> void:
	#Handling Mouse Movement for the Aim Container/CueStick
	var mouse_motion = event as InputEventMouseMotion
	if mouse_motion:
		_aim_container.rotation_degrees.y += mouse_motion.relative.x
		
		#Setting Shot Percent and move the stick forward or backward
		_shot_percent += mouse_motion.relative.y * _stick_sensitivity
		_shot_percent = clamp(_shot_percent, 0,1)
		_cue_stick.position.z = lerp(_stick_min_z, _stick_max_z, _shot_percent)
		
		#Moving the Cue Stick forward/backward
		#_cue_stick.position.z += mouse_motion.relative.y * _stick_sensitivity
		#_cue_stick.position.z = clamp(_cue_stick.position.z, _stick_min_z,_stick_max_z )

func _handle_shot_input():
	#Shooting the ball
	if Input.is_action_just_pressed("shoot"):
		_stick_animation_player.play("shoot_stick")

func _shoot_ball():
	#Shooting the ball
	var _shot_power := lerp(_shot_power_min, _shot_power_max, _shot_percent) as float
	var stick_direction = -_aim_container.basis.z
	var _shot_vector = stick_direction * _shot_power
	
	_cue_ball.apply_central_impulse(_shot_vector)
	#Hide the stick while shot is processing
	_cue_stick.visible = false
	
	GameEvents.cue_ball_hit.emit()
