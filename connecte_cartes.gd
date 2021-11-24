extends PanelContainer


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


signal finished
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/GraphEdit.connect("finished",self,"on_finished")
	$VBoxContainer/GraphEdit.connect("failed",self,"on_failed")

func on_finished():
	emit_signal("finished")

func on_failed():
	$AcceptDialog.popup_centered()
