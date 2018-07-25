Class {
	#name : #PBCreateAssemblyCommand,
	#superclass : #CGOProjectCommand,
	#category : #'CargoPackageManager-Calypso-Browser-Commands'
}

{ #category : #accessing }
PBCreateAssemblyCommand class >> defaultMenuIconName [

	^#newerPackagesAvailable
]

{ #category : #execution }
PBCreateAssemblyCommand class >> execute [
	
	^ self name , ' Assembly'
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
	project project addAssemblyNamed: assemblyName.
]
