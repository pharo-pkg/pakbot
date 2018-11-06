"
Calypso plugin to display a tab when a package assembly is selected.
This plugin will allow to show / edit package metadata.
"
Class {
	#name : #CGOBrowserPackageAssemblyEditorToolMorph,
	#superclass : #ClyBrowserToolMorph,
	#category : #'CargoPackageManager-Calypso-Browser-Tools'
}

{ #category : #accessing }
CGOBrowserPackageAssemblyEditorToolMorph class >> methodTabActivation [
	<classAnnotation>
	
	^ClyTabActivationStrategy for: CGOClyPackageAssembly asCalypsoItemContext 
]

{ #category : #accessing }
CGOBrowserPackageAssemblyEditorToolMorph class >> tabOrder [
	^ 0
]

{ #category : #accessing }
CGOBrowserPackageAssemblyEditorToolMorph >> activeColor [
	^ Color transparent
]

{ #category : #initialization }
CGOBrowserPackageAssemblyEditorToolMorph >> build [
	| managedAssembly |
	managedAssembly := context lastSelectedProjectChild.
	self 
		addMorph: (CGOPackageAssemblyView buildOnOngoing: managedAssembly cargoAssembly asOngoingPackageVersion)
		fullFrame: LayoutFrame identity
]

{ #category : #initialization }
CGOBrowserPackageAssemblyEditorToolMorph >> defaultTitle [
	^ 'Assembly'
]
