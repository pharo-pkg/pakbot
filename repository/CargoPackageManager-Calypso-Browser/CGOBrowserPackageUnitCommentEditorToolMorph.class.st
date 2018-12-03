Class {
	#name : #CGOBrowserPackageUnitCommentEditorToolMorph,
	#superclass : #ClyTextEditorToolMorph,
	#instVars : [
		'project'
	],
	#category : #'CargoPackageManager-Calypso-Browser-Tools'
}

{ #category : #accessing }
CGOBrowserPackageUnitCommentEditorToolMorph class >> methodTabActivation [
	<classAnnotation>
	
	^ClyTabActivationStrategy for: PBPackageUIItem asCalypsoItemContext 
]

{ #category : #accessing }
CGOBrowserPackageUnitCommentEditorToolMorph class >> tabOrder [
	^ 0
]

{ #category : #accessing }
CGOBrowserPackageUnitCommentEditorToolMorph >> activeColor [
	^ Color transparent
]

{ #category : #operations }
CGOBrowserPackageUnitCommentEditorToolMorph >> applyChanges [

	self unit description: self pendingText asString.
	^ true
]

{ #category : #initialization }
CGOBrowserPackageUnitCommentEditorToolMorph >> defaultTitle [
	^ 'Comment'
]

{ #category : #accessing }
CGOBrowserPackageUnitCommentEditorToolMorph >> editingText [
	^ self unit description ifNil: [ '' ]
]

{ #category : #accessing }
CGOBrowserPackageUnitCommentEditorToolMorph >> unit [
	^ context lastSelectedPBPackage cargoPackage
]

{ #category : #testing }
CGOBrowserPackageUnitCommentEditorToolMorph >> wantsTextStyling [
	^ false
]
