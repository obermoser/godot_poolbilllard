#By Bernhard Obermoser 2025
class_name Ball
extends RigidBody3D

const BALL_RADIUS = 0.027

@export var _texture : Texture2D

func _ready() -> void:
	#Creating a new Material
	var _new_material = StandardMaterial3D.new()
	#Apply selected texture to the material
	_new_material.albedo_texture = _texture
	
	#Apply the new Material to the Mesh
	$BallMesh.material_override = _new_material
