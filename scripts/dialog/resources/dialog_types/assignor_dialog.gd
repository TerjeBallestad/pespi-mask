class_name AssignorDialog extends Dialog

@export
var variable_name: String

@export
var operator: Operator

@export
var value: Variant

func on_display(_box: DialogBox) -> void:
	var var_exists := DialogManager.variables.has(variable_name)
	
	match operator:
		Operator.ASSIGN:
			DialogManager.variables[variable_name] = value
			
		Operator.DELETE:
			DialogManager.variables.erase(variable_name)
			
		Operator.INCREMENT:
			if not var_exists:
				DialogManager.variables[variable_name] = 1
			else:
				DialogManager.variables[variable_name] = DialogManager.variables[variable_name] + 1
				
		Operator.DECREMENT:
			if not var_exists:
				DialogManager.variables[variable_name] = -1
			else:
				DialogManager.variables[variable_name] = DialogManager.variables[variable_name] - 1
				
	DialogManager.next_dialog()
	
enum Operator {
	## Assigns the value to the variable
	ASSIGN,
	
	## Deletes the variable
	DELETE,
	
	## Increments the variable by value. Sets to 1 if non-existent
	INCREMENT,
	
	## Decrements the variable by value. Sets to -1 if non-existent
	DECREMENT,
}
