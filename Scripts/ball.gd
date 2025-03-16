#By Bernhard Obermoser 2025
class_name Ball
extends RigidBody3D

const BALL_RADIUS := 0.027
const BALL_DIAMETER := BALL_RADIUS * 2

static var num_balls_moving : int = 0

var _ball_num := 0
var _texture : Texture2D
var _ball_type : Enums.BallType = Enums.BallType.CUE_BALL

func _ready() -> void:
	GameEvents.ball_potted.connect(_on_ball_potted)
	if not self.sleeping:
		self.sleeping = true
		Ball.num_balls_moving += 1	
		
	_apply_new_material()


func _physics_process(_delta: float) -> void:
		self.linear_velocity.y = min(Ball.BALL_DIAMETER,self.linear_velocity.y)


func setup_ball(ball_num:int, ball_x:float, ball_z:float)->void:
	_ball_num = ball_num
	
	if _ball_num == 8:
		_ball_type = Enums.BallType.EIGHT_BALL
	elif ball_num == 0:
		_ball_type = Enums.BallType.CUE_BALL
	elif _ball_num <8:
		self._ball_type = Enums.BallType.SOLIDS
	else:
		self._ball_type = Enums.BallType.STRIPES	
	
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


func _on_sleeping_state_changed() -> void:
	if self.sleeping:
		Ball.num_balls_moving -= 1
	else:
		Ball.num_balls_moving += 1
		
	if Ball.num_balls_moving == 0:
		GameEvents.all_balls_stopped.emit()

## This executes when the ball has landed in the pocket
func _on_ball_potted(ball, pocket):
	if ball == self:
		self.freeze = true
		self.sleeping = true
		self.sleeping_state_changed.emit()
		self.position = Vector3(0,-0.5,0)
