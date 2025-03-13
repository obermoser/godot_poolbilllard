#By Bernhard Obermoser 2025
class_name Ball
extends RigidBody3D

const BALL_RADIUS := 0.027
const BALL_DIAMETER := BALL_RADIUS * 2

@export var _texture : Texture2D

func _ready() -> void:
	_apply_new_material()


func setup_ball(ball_num:int, ball_x:float, ball_z:float)->void:
	self.position.x = ball_x
	self.position.z = ball_z
	
	_texture = load("res://assets/textures/" + str(ball_num) + ".jpg")
	
	_apply_new_material()

func _apply_new_material():
	#Creating a new Material
	var _new_material = StandardMaterial3D.new()
	#Apply selected texture to the material
	_new_material.albedo_texture = _texture
	
	#Apply the new Material to the Mesh
	$BallMesh.material_override = _new_material
