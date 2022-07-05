extends VBoxContainer

signal option_button_pressed(id, label)

onready var output := get_node("Output")
onready var _input_container := get_node("InputContainer")


func add_output(output_text: String) -> void:
	output.add_text("\n%s" % output_text)


func add_option_button(label: String, id: int) -> void:
	var new_button = Button.new()
	new_button.text = label
	new_button.set_meta("option_id", id)
	new_button.connect("pressed", self, "_on_option_button_pressed", [new_button])
	_input_container.add_child(new_button)


func clear_option_buttons() -> void:
	for child in _input_container.get_children():
		child.queue_free()


func _on_option_button_pressed(pressed_button: Button) -> void:
	emit_signal("option_button_pressed", pressed_button.get_meta("option_id"), pressed_button.text)
