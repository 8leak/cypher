class_name Utils
extends Reference


# attempts to format a reference in a human-readable way
# - `reference`, `Reference`: the reference to print
static func pprint(reference: Reference) -> void:
	match reference.get_class():
		"Dictionary", "Array":
			print(JSON.print(reference, "  "))
		_:
			print(reference)


# return a random element from an iterable
# - choices, Iterable: the iterable to return a random element from
# - returns Variant: a random element from the iterable
static func choice(choices):
	if choices.size() > 0:
		return choices[Game.rng.randi_range(0, choices.size() - 1)]
	Game.logger.error("Invalid choice object: %s" % str(choices))
	return choices
