extends PanelContainer

onready var texture_buttons = $VBoxContainer/TextureButtons
onready var popup = $Popup

func _ready() -> void:
	for k in [
			"res://assets/A1.png",
			"res://assets/A2.png",
			"res://assets/A3.png",
			"res://assets/A4.png",
			"res://assets/A5.png",
			"res://assets/A6.png",
			"res://assets/A7.png",
			"res://assets/A8.png"
		]:
		var button = preload("res://TextureButton.tscn").instance()
		button.texture_normal = load(k)
		button.texture_focused = load(k)
		button.texture_hover = load(k)
		button.texture_pressed = load(k)
		button.connect("pressed",self,"on_pressed",[k])
		texture_buttons.add_child(button)

	pass # Replace with function body.

func on_pressed(img_path):
	popup.get_node("TextureRect").texture = load(img_path)
	popup.popup_centered()
