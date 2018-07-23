"
Calypso plugin to display a tab when a virtual package is selected.
This plugin will allow to show / edit package metadata.
"
Class {
	#name : #CGOBrowserVirtualPackageEditorTool,
	#superclass : #ClyBrowserTool,
	#category : #'CargoPackageManager-Calypso-Browser-Tools'
}

{ #category : #accessing }
CGOBrowserVirtualPackageEditorTool class >> methodTabActivation [
	<classAnnotation>
	
	^ClyTabActivationStrategy for: CGOClyVirtualPackage asCalypsoItemContext  
]

{ #category : #accessing }
CGOBrowserVirtualPackageEditorTool class >> tabOrder [
	^ 0
]

{ #category : #accessing }
CGOBrowserVirtualPackageEditorTool >> activeColor [
	^ Color transparent
]

{ #category : #initialization }
CGOBrowserVirtualPackageEditorTool >> build [
	| virtual |
	virtual := context lastSelectedProjectChild cargoPackage.
	
	self 
		addMorph: (CGOVirtualPackageView buildOnOngoing: virtual asOngoingPackageVersion)
		fullFrame: LayoutFrame identity.
]

{ #category : #initialization }
CGOBrowserVirtualPackageEditorTool >> defaultTitle [
	^ 'Virtual'
]
