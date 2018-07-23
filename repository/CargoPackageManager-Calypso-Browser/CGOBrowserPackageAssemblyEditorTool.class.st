"
Calypso plugin to display a tab when a package assembly is selected.
This plugin will allow to show / edit package metadata.
"
Class {
	#name : #CGOBrowserPackageAssemblyEditorTool,
	#superclass : #ClyBrowserTool,
	#category : #'CargoPackageManager-Calypso-Browser-Tools'
}

{ #category : #accessing }
CGOBrowserPackageAssemblyEditorTool class >> methodTabActivation [
	<classAnnotation>
	
	^ClyTabActivationStrategy for: CGOClyPackageAssembly asCalypsoItemContext 
]

{ #category : #accessing }
CGOBrowserPackageAssemblyEditorTool class >> tabOrder [
	^ 0
]

{ #category : #accessing }
CGOBrowserPackageAssemblyEditorTool >> activeColor [
	^ Color transparent
]

{ #category : #initialization }
CGOBrowserPackageAssemblyEditorTool >> build [
	| managedAssembly |
	managedAssembly := context lastSelectedProjectChild.
	self 
		addMorph: (CGOPackageAssemblyView buildOnOngoing: managedAssembly cargoAssembly asOngoingPackageVersion)
		fullFrame: LayoutFrame identity
]

{ #category : #initialization }
CGOBrowserPackageAssemblyEditorTool >> defaultTitle [
	^ 'Assembly'
]
