extends RigidBody3D

@export var _texture : Texture2D

func _ready() -> void:
	
	var _new_material = StandardMaterial3D.new()
	_new_material.albedo_texture = _texture
	
	$BallMesh.material_override = _new_material
