extends Camera3D

func _ready() -> void:
	GameEvents.cue_ball_hit.connect(_on_cue_ball_hit)
	

#Making the overhead cam current as soon as we hit the cue ball with the stick
func _on_cue_ball_hit() -> void:
	self.make_current()
