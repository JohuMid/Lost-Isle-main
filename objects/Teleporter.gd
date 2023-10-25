extends Interactable
class_name Teleporter

#export (String, FILE,".tscn") var target_path: String
#@export var target_path: String
@export_file("*.tscn") var target_path: String

func _interact():
	super._interact()
	SceneChanger.change_scene(target_path)
