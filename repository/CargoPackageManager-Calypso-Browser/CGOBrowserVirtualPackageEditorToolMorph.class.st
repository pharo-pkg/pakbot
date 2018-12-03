"
Calypso plugin to display a tab when a virtual package is selected.
This plugin will allow to show / edit package metadata.
"
Class {
	#name : #CGOBrowserVirtualPackageEditorToolMorph,
	#superclass : #ClyBrowserToolMorph,
	#category : #'CargoPackageManager-Calypso-Browser-Tools'
}

{ #category : #accessing }
CGOBrowserVirtualPackageEditorToolMorph class >> methodTabActivation [
	<classAnnotation>
	
	^ClyTabActivationStrategy for: CGOClyVirtualPackage asCalypsoItemContext  
]

{ #category : #accessing }
CGOBrowserVirtualPackageEditorToolMorph class >> tabOrder [
	^ 0
]

{ #category : #accessing }
CGOBrowserVirtualPackageEditorToolMorph >> activeColor [
	^ Color transparent
]

{ #category : #initialization }
CGOBrowserVirtualPackageEditorToolMorph >> build [
	| virtual |
	virtual := context lastSelectedProjectChild cargoPackage.
	
	self 
		addMorph: (CGOVirtualPackageView buildOnOngoing: virtual asOngoingPackageVersion)
		fullFrame: LayoutFrame identity.
]

{ #category : #initialization }
CGOBrowserVirtualPackageEditorToolMorph >> defaultTitle [
	^ 'Virtual'
]
