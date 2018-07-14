Class {
	#name : #CGORepairProjectCommand,
	#superclass : #CGOProjectCommand,
	#category : 'CargoPackageManager-Calypso-Browser-CargoPackageManager-Calypso-Browser'
}

{ #category : #testing }
CGORepairProjectCommand class >> canBeExecutedInContext: aToolContext [

	^ (aToolContext isProjectSelected and: [ aToolContext selectedProjectItems size = 1 ])
		and: [ aToolContext selectedProjectItems first actualObject project hasProblems ]
]

{ #category : #accessing }
CGORepairProjectCommand class >> defaultMenuIconName [
	^ #repair
]

{ #category : #activation }
CGORepairProjectCommand class >> defaultMenuItemName [
	^ 'Repair Project'
]

{ #category : #activation }
CGORepairProjectCommand class >> systemBrowserMenuActivator [
	<classAnnotation>
	
	^ CmdContextMenuActivation byRootGroupItemOrder: 1 for: ClyManagedProject asCalypsoItemContext
]

{ #category : #execution }
CGORepairProjectCommand >> execute [
	
	(CGOOpenRepairDialog onProject: self project) execute
]
