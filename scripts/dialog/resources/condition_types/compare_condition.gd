class_name CompareDialogCondition extends DialogCondition

@export
var variable_name: String

@export
var operator: Operator

@export
var value: Variant

func is_condition_met() -> bool:
	var var_exists := DialogManager.variables.has(variable_name)
	var var_value = null
	
	if var_exists:
		var_value = DialogManager.variables[variable_name]
	
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
			
		Operator.IS_UNSET_OR_ZERO:
			return not var_exists or var_value == 0
			
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
	## Variable exists. Value is unused for this operator
	IS_SET,
	
	## Variable does not exist. Value is unused for this operator
	IS_UNSET,
	
	## Variable does not exist or is zero. Value is unused for this operator
	IS_UNSET_OR_ZERO,
	
	## Variable is equal to value
	EQUALS,
	
	## Variable is different from value
	NOT_EQUALS,
	
	## Variable is less than value
	LESS_THAN,
	
	## Variable is greater than value
	GREATER_THAN,
	
	## Variable is less than or equal to value
	LESS_THAN_OR_EQUAL,
	
	## Variable is greater than or equal to value
	GREATER_THAN_OR_EQUAL
}
