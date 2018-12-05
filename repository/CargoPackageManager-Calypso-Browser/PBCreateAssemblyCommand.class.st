"
Calypso command providing a contextual menu to create a new (empty) assembly into a project
"
Class {
	#name : #PBCreateAssemblyCommand,
	#superclass : #PBProjectCommand,
	#category : #'CargoPackageManager-Calypso-Browser-Commands'
}

{ #category : #accessing }
PBCreateAssemblyCommand class >> defaultMenuIconName [

	^#newerPackagesAvailable
]

{ #category : #activation }
PBCreateAssemblyCommand class >> systemBrowserMenuActivator [
	<classAnnotation>
	
	^ CmdContextMenuActivation byRootGroupItemOrder: 20 for: PBProjectUIItem asCalypsoItemContext
]

{ #category : #execution }
PBCreateAssemblyCommand >> defaultMenuItemName [
	^ 'New Assembly'
]

{ #category : #execution }
PBCreateAssemblyCommand >> execute [
	| assemblyName |
	assemblyName := UIManager default 
		request: 'New assembly name' 
		initialAnswer: project name, '-'.
	assemblyName isEmptyOrNil ifTrue: [ CmdCommandAborted signal ].
	project addAssemblyNamed: assemblyName.
]
