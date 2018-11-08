"
Calypso plugin to display a tab when a project is selected.
This plugin will allow to show / edit project metadata.
"
Class {
	#name : #CGOBrowserProjectEditorToolMorph,
	#superclass : #ClyBrowserToolMorph,
	#instVars : [
		'managedProject'
	],
	#category : #'CargoPackageManager-Calypso-Browser-Tools'
}

{ #category : #accessing }
CGOBrowserProjectEditorToolMorph class >> methodTabActivation [
	<classAnnotation>
	
	^ClyTabActivationStrategy for: PBProjectUIItem asCalypsoItemContext 
]

{ #category : #accessing }
CGOBrowserProjectEditorToolMorph class >> methodTabActivationForDependencies [
	<classAnnotation>
	
	^ClyTabActivationStrategy for: PBDependencyUIItem asCalypsoItemContext 
]

{ #category : #accessing }
CGOBrowserProjectEditorToolMorph class >> methodTabActivationForDependenciesGroup [
	<classAnnotation>
	
	^ClyTabActivationStrategy for: PBDependenciesUIGroup asCalypsoItemContext 
]

{ #category : #accessing }
CGOBrowserProjectEditorToolMorph class >> tabOrder [
	^ 0
]

{ #category : #accessing }
CGOBrowserProjectEditorToolMorph >> activeColor [
	^ Color transparent
]

{ #category : #initialization }
CGOBrowserProjectEditorToolMorph >> belongsToCurrentBrowserContext [
	^browser projectSelection includesActualObject: managedProject
]

{ #category : #initialization }
CGOBrowserProjectEditorToolMorph >> build [
	self 
		addMorph: (PBProjectPanel buildOnOngoing: managedProject project asOngoingPackage)
]

{ #category : #initialization }
CGOBrowserProjectEditorToolMorph >> defaultTitle [
	^ 'Project'
]

{ #category : #initialization }
CGOBrowserProjectEditorToolMorph >> isSimilarTo: anotherTool [

	^ (super isSimilarTo: anotherTool)
		and: [ managedProject = anotherTool managedProject ]
]

{ #category : #initialization }
CGOBrowserProjectEditorToolMorph >> managedProject [

	^ managedProject
]

{ #category : #initialization }
CGOBrowserProjectEditorToolMorph >> setUpModelFromContext [
	managedProject := context lastSelectedProject.
	
]
