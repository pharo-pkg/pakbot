Class {
	#name : #PBRepairProjectCommand,
	#superclass : #CGOProjectCommand,
	#category : #'CargoPackageManager-Calypso-Browser-Commands'
}

{ #category : #testing }
PBRepairProjectCommand class >> canBeExecutedInContext: aToolContext [

	^ (aToolContext isProjectSelected and: [ aToolContext selectedProjectItems size = 1 ])
		and: [ aToolContext selectedProjectItems first actualObject project hasProblems ]
]

{ #category : #accessing }
PBRepairProjectCommand class >> defaultMenuIconName [
	^ #repair
]

{ #category : #activation }
PBRepairProjectCommand class >> defaultMenuItemName [
	^ 'Repair Project'
]

{ #category : #activation }
PBRepairProjectCommand class >> systemBrowserMenuActivator [
	<classAnnotation>
	
	^ CmdContextMenuActivation byRootGroupItemOrder: 1 for: PBProjectUIItem asCalypsoItemContext
]

{ #category : #execution }
PBRepairProjectCommand >> execute [
	
	self project openRepairDialog.

]
