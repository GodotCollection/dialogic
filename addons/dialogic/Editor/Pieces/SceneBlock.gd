tool
extends PanelContainer

var editor_reference
var editorPopup
var preview = "..."
onready var toggler = get_node("VBoxContainer/Header/VisibleToggle")

# This is the information of this event and it will get parsed and saved to the JSON file.
var event_data = {
	'background': ''
}

func _ready():
	connect("gui_input", self, '_on_gui_input')
	load_image(event_data['background'])

func _on_ImageButton_pressed():
	var file_dialog = editor_reference.godot_dialog()
	file_dialog.add_filter("*.png, *.jpg, *.jpeg, *.tga, *.svg, *.svgz, *.bmp, *.webp;Image")
	#file_dialog.connect("file_selected", self, "_on_file_selected", [self])
	editor_reference.godot_dialog_connect(self, "_on_file_selected")
	

func _on_file_selected(path, target):
	print('here')
	target.load_image(path)

func load_image(img_src):
	event_data['background'] = img_src
	if event_data['background'] != '':
		$VBoxContainer/HBoxContainer/LineEdit.text = event_data['background']
		$VBoxContainer/TextureRect.texture = load(event_data['background'])
		$VBoxContainer/TextureRect.rect_min_size = Vector2(200,200)
		preview = event_data['background']
	else:
		$VBoxContainer/TextureRect.rect_min_size = Vector2(0,0)

func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == 1:
			if toggler.pressed:
				toggler.pressed = false
			else:
				toggler.pressed = true
