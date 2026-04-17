@tool
extends EditorPlugin

const SIZE = Vector2(450, 700)

var camera_editor_button := Button.new()
var popup := PopupPanel.new()

var inspector := EditorInspector.new()
var editor_property := EditorProperty.new()

func _enter_tree() -> void:
	camera_editor_button.text = "Camera"
	camera_editor_button.pressed.connect(_on_camera_editor_button_pressed)
	add_control_to_container(CONTAINER_SPATIAL_EDITOR_MENU, camera_editor_button)
	
	popup.add_child(inspector)
	
	EditorInterface.get_base_control().add_child(popup)


func _exit_tree() -> void:
	remove_control_from_container(CONTAINER_SPATIAL_EDITOR_MENU, camera_editor_button)
	camera_editor_button.queue_free()
	popup.queue_free()


func _on_camera_editor_button_pressed() -> void:
	inspector.edit(EditorInterface.get_editor_viewport_3d(0).get_camera_3d())
	
	var btn_rect = camera_editor_button.get_screen_position()
	var btn_size = camera_editor_button.size
	popup.popup(Rect2(btn_rect + Vector2(0, btn_size.y), SIZE))
