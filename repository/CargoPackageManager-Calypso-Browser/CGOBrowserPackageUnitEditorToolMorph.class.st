"
Calypso plugin to display a tab when a package unit is selected.
This plugin will allow to show / edit package metadata.
"
Class {
	#name : #CGOBrowserPackageUnitEditorToolMorph,
	#superclass : #ClyBrowserToolMorph,
	#category : #'CargoPackageManager-Calypso-Browser-Tools'
}

{ #category : #accessing }
CGOBrowserPackageUnitEditorToolMorph class >> methodTabActivation [
	<classAnnotation>
	
	^ClyTabActivationStrategy for: PBPackageUIItem asCalypsoItemContext
]

{ #category : #accessing }
CGOBrowserPackageUnitEditorToolMorph class >> tabOrder [
	^ 0
]

{ #category : #accessing }
CGOBrowserPackageUnitEditorToolMorph >> activeColor [
	^ Color transparent
]

{ #category : #initialization }
CGOBrowserPackageUnitEditorToolMorph >> build [
	| aPackage |
		
	aPackage := context selectedItems first actualObject.
	
	self 
		addMorph: (CGOPackageUnitView on: aPackage package) buildWithSpec
		fullFrame: LayoutFrame identity
]

{ #category : #initialization }
CGOBrowserPackageUnitEditorToolMorph >> defaultTitle [
	^ 'Unit'
]
