"
Calypso plugin to display a tab when a project is selected.
This plugin will allow to show / edit project metadata.
"
Class {
	#name : #CGOBrowserProjectEditorTool,
	#superclass : #ClyBrowserTool,
	#instVars : [
		'managedProject'
	],
	#category : #'CargoPackageManager-Calypso-Browser-Tools'
}

{ #category : #accessing }
CGOBrowserProjectEditorTool class >> methodTabActivation [
	<classAnnotation>
	
	^ClyTabActivationStrategy for: PBProjectUIItem asCalypsoItemContext 
]

{ #category : #accessing }
CGOBrowserProjectEditorTool class >> methodTabActivationForDependencies [
	<classAnnotation>
	
	^ClyTabActivationStrategy for: PBDependencyUIItem asCalypsoItemContext 
]

{ #category : #accessing }
CGOBrowserProjectEditorTool class >> methodTabActivationForDependenciesGroup [
	<classAnnotation>
	
	^ClyTabActivationStrategy for: PBDependenciesUIGroup asCalypsoItemContext 
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
CGOBrowserProjectEditorTool >> belongsToCurrentBrowserContext [
	^browser projectSelection includesActualObject: managedProject
]

{ #category : #initialization }
CGOBrowserProjectEditorTool >> build [
	self 
		addMorph: (PBProjectPanel buildOnOngoing: managedProject project asOngoingPackage)
]

{ #category : #initialization }
CGOBrowserProjectEditorTool >> defaultTitle [
	^ 'Project'
]

{ #category : #initialization }
CGOBrowserProjectEditorTool >> isSimilarTo: anotherTool [

	^ (super isSimilarTo: anotherTool)
		and: [ managedProject = anotherTool managedProject ]
]

{ #category : #initialization }
CGOBrowserProjectEditorTool >> managedProject [

	^ managedProject
]

{ #category : #initialization }
CGOBrowserProjectEditorTool >> setUpModelFromContext [
	managedProject := context lastSelectedProject.
	
]
