decoration
decorateMainTableCell: anItemCellMorph inContext: itemContext

	| command activator icon button |
	
	command := CGORepairProjectCommand new.
	itemContext prepareNewCommand: command.
	activator := CmdCommandActivator new 
			command: command; 
			context: itemContext.

	icon := anItemCellMorph iconNamed: #error.
	button := command createTableCellButtonWith: icon using: activator.
	button setBalloonText: 'The project is not up to date'.
	anItemCellMorph definitionMorph: button