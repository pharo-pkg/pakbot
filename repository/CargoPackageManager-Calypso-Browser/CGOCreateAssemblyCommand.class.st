Class {
	#name : #CGOCreateAssemblyCommand,
	#superclass : #CGOProjectCommand,
	#category : #'CargoPackageManager-Calypso-Browser-Commands'
}

{ #category : #accessing }
CGOCreateAssemblyCommand class >> defaultMenuIconName [

	^#newerPackagesAvailable
]

{ #category : #execution }
CGOCreateAssemblyCommand class >> execute [
	
	^ self name , ' Assembly'
]

{ #category : #activation }
CGOCreateAssemblyCommand class >> systemBrowserMenuActivator [
	<classAnnotation>
	
	^ CmdContextMenuActivation byRootGroupItemOrder: 20 for: PBProjectUIItem asCalypsoItemContext
]

{ #category : #execution }
CGOCreateAssemblyCommand >> defaultMenuItemName [
	^ 'New Assembly'
]

{ #category : #execution }
CGOCreateAssemblyCommand >> execute [
	| assemblyName |
	assemblyName := UIManager default 
		request: 'New assembly name' 
		initialAnswer: project name, '-'.
	assemblyName isEmptyOrNil ifTrue: [ CmdCommandAborted signal ].
	project project addAssemblyNamed: assemblyName.
]
