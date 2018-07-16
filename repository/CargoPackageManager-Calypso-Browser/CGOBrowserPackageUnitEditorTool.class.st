"
Calypso plugin to display a tab when a package unit is selected.
This plugin will allow to show / edit package metadata.
"
Class {
	#name : #CGOBrowserPackageUnitEditorTool,
	#superclass : #ClyBrowserTool,
	#category : #'CargoPackageManager-Calypso-Browser-Tools'
}

{ #category : #accessing }
CGOBrowserPackageUnitEditorTool class >> methodTabActivation [
	<classAnnotation>
	
	^ClyTabActivationStrategy for: ClyManagedPackage asCalypsoItemContext
]

{ #category : #accessing }
CGOBrowserPackageUnitEditorTool class >> tabOrder [
	^ 0
]

{ #category : #accessing }
CGOBrowserPackageUnitEditorTool >> activeColor [
	^ Color transparent
]

{ #category : #initialization }
CGOBrowserPackageUnitEditorTool >> build [
	| packageManager unit |
	packageManager := context systemEnvironment projectManager packageManagers first.
	unit := packageManager versionOf: context lastSelectedPackage.
	
	self 
		addMorph: (CGOPackageUnitView buildOnOngoing: unit asOngoingPackageVersion)
		fullFrame: LayoutFrame identity
]

{ #category : #initialization }
CGOBrowserPackageUnitEditorTool >> defaultTitle [
	^ 'Unit'
]
