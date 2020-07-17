Extension { #name : #PBProjectUIItem }

{ #category : #'*CargoPackageManager-Calypso-Browser' }
PBProjectUIItem >> decorateProblems: anItemCellMorph inContext: itemContext [
	| button activator icon command |	
	command := PBRepairProjectCommand new.
	itemContext prepareNewCommand: command.
	
	activator := CmdCommandActivator new
		command: command;
		context: itemContext.
	
	icon := anItemCellMorph iconNamed: #error.
	button := command createTableCellButtonWith: icon using: activator.
	button setBalloonText: 'The project is not up to date'.
	anItemCellMorph definitionMorph: button
]
