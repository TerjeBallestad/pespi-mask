## Condition that is the opposite of the node above's
## Can be used for 'else' blocks or combined with other conditions for 'elif's

class_name ElseCondition extends DialogCondition

func is_condition_met() -> bool:
	return not DialogManager.previous_node_condition_result
