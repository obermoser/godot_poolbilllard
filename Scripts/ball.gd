#By Bernhard Obermoser 2025
extends RigidBody3D

@export var _texture : Texture2D

func _ready() -> void:
	#Creating a new Material
	var _new_material = StandardMaterial3D.new()
	#Apply selected texture to the material
	_new_material.albedo_texture = _texture
	
	#Apply the new Material to the Mesh
	$BallMesh.material_override = _new_material
