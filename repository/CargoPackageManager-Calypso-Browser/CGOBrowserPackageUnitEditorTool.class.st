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
	
	^ClyTabActivationStrategy for: PBPackageUIItem asCalypsoItemContext
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
	| aPackage |
		
	aPackage := context selectedItems first actualObject.
	
	self 
		addMorph: (CGOPackageUnitView on: aPackage unit) buildWithSpec
		fullFrame: LayoutFrame identity
]

{ #category : #initialization }
CGOBrowserPackageUnitEditorTool >> defaultTitle [
	^ 'Unit'
]
