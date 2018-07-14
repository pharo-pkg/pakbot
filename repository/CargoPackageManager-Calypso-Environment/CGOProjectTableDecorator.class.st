Class {
	#name : #CGOProjectTableDecorator,
	#superclass : #ClyTableDecorator,
	#category : 'CargoPackageManager-Calypso-Environment'
}

{ #category : #decoration }
CGOProjectTableDecorator class >> browserDecorationStrategy [
	<classAnnotation>
	
	^ClyTableDecorationStrategy for: ClyProjectContextOfFullBrowser
]

{ #category : #decoration }
CGOProjectTableDecorator class >> decorateMainTableCell: anItemCellMorph inContext: itemContext [

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
]

{ #category : #decoration }
CGOProjectTableDecorator class >> decorateTableCell: anItemCellMorph of: aDataSourceItem [

]

{ #category : #decoration }
CGOProjectTableDecorator class >> priority [
	^200
]

{ #category : #decoration }
CGOProjectTableDecorator class >> wantsDecorateTableCellOf: aDataSourceItem [
		
	^aDataSourceItem isMarkedWith: CGOProjectHasProblems 
]
