class_name Conversation

signal new_output(new_output)
signal new_options(new_options)

const test_data := {
	0: {
		"output": "test response 1",
		"options": [{"text": "test option 3", "id": 2}]
	},
	1: {
		"output": "test response 2",
		"options": [{"text": "test option 4", "id": 3}]
	}
}

func start() -> void:
	emit_signal("new_output", "This is the start of the conversation")
	
	var options = [
		{
			"text": "Test option 1",
			"id": 0
		},
		{
			"text": "Test option 2",
			"id": 1
		},
	]

	emit_signal("new_options", options)


func select_option(id: int) -> void:
	var data = test_data.get(id)
	if not data:
		return

	emit_signal("new_output", data["output"])
	emit_signal("new_options", data["options"])
