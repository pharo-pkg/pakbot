"
Calypso plugin to display a tab when a project is selected.
This plugin will allow to show / edit project metadata.
"
Class {
	#name : #CGOBrowserProjectEditorTool,
	#superclass : #ClyBrowserTool,
	#category : 'CargoPackageManager-Calypso-Browser-CargoPackageManager-Calypso-Browser'
}

{ #category : #accessing }
CGOBrowserProjectEditorTool class >> methodTabActivation [
	<classAnnotation>
	
	^ClyTabActivationStrategy for: ClyManagedProject asCalypsoItemContext 
]

{ #category : #accessing }
CGOBrowserProjectEditorTool class >> tabOrder [
	^ 0
]

{ #category : #accessing }
CGOBrowserProjectEditorTool >> activeColor [
	^ Color transparent
]

{ #category : #initialization }
CGOBrowserProjectEditorTool >> build [
	| managedProject |
	managedProject := context lastSelectedProject.
	self 
		addMorph: (CGOProjectPanel buildOnOngoing: managedProject project asOngoingPackage)
		fullFrame: LayoutFrame identity
]

{ #category : #initialization }
CGOBrowserProjectEditorTool >> defaultTitle [
	^ 'Project'
]
