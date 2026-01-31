class_name CompoundDialogCondition extends DialogCondition

@export
var conditions: Array[DialogCondition]

@export
var operator: Operator

func is_condition_met(manager: DialogManager) -> bool:
	match operator:
		Operator.ALL:
			return conditions.all(func(i): return i.is_condition_met(manager))
			
		Operator.ANY:
			return conditions.any(func(i): return i.is_condition_met(manager))

		Operator.ONE:
			return conditions.count(func(i): return i.is_condition_met(manager)) == 1

		Operator.NONE:
			return not conditions.any(func(i): return i.is_condition_met(manager))

		_:
			return false # Wizard you are, huh

enum Operator {
	## All conditions must be met
	ALL,
	
	## At least one condition must be met
	ANY,
	
	## Exactly one condition must be met
	ONE,
	
	## No condition must be met
	NONE
}
