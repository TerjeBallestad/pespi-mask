@tool
class_name CompareDialogCondition extends DialogCondition

@export
var variable_name: String

@export
var operator: Operator

@export
var value: Variant

func is_condition_met(manager: DialogManager) -> bool:
	var var_exists := manager.variables.has(variable_name)
	var var_value = null
	
	if var_exists:
		var_value = manager.variables[variable_name]
	
	# Some of these are unsafe. Just don't be an idiotia maxima in the editor pls
	match operator:
		Operator.IS_SET:
			return var_exists
		
		Operator.IS_UNSET:
			return not var_exists
			
		Operator.EQUALS:
			return var_value == value
			
		Operator.NOT_EQUALS:
			return var_value != value
			
		Operator.GREATER_THAN:
			return var_exists and var_value > value
			
		Operator.GREATER_THAN:
			return var_exists and var_value > value
		
		Operator.LESS_THAN:
			return var_exists and var_value < value
			
		Operator.GREATER_THAN_OR_EQUAL:
			return var_exists and var_value >= value
			
		Operator.LESS_THAN_OR_EQUAL:
			return var_exists and var_value <= value
			
		_:
			return false # How did we get here?
	
	

enum Operator {
	IS_SET,
	IS_UNSET,
	EQUALS,
	NOT_EQUALS,
	LESS_THAN,
	GREATER_THAN,
	LESS_THAN_OR_EQUAL,
	GREATER_THAN_OR_EQUAL
}
