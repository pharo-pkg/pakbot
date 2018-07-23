Class {
	#name : #CGOBrowserPackageUnitCommentEditorTool,
	#superclass : #ClyTextEditorTool,
	#instVars : [
		'project'
	],
	#category : #'CargoPackageManager-Calypso-Browser-Tools'
}

{ #category : #accessing }
CGOBrowserPackageUnitCommentEditorTool class >> methodTabActivation [
	<classAnnotation>
	
	^ClyTabActivationStrategy for: PBPackageUIItem asCalypsoItemContext 
]

{ #category : #accessing }
CGOBrowserPackageUnitCommentEditorTool class >> tabOrder [
	^ 0
]

{ #category : #accessing }
CGOBrowserPackageUnitCommentEditorTool >> activeColor [
	^ Color transparent
]

{ #category : #operations }
CGOBrowserPackageUnitCommentEditorTool >> applyChanges [

	self unit description: self pendingText asString.
	^ true
]

{ #category : #initialization }
CGOBrowserPackageUnitCommentEditorTool >> defaultTitle [
	^ 'Comment'
]

{ #category : #accessing }
CGOBrowserPackageUnitCommentEditorTool >> editingText [
	^ self unit description
]

{ #category : #accessing }
CGOBrowserPackageUnitCommentEditorTool >> unit [
	^ context lastSelectedPBPackage cargoPackage
]

{ #category : #testing }
CGOBrowserPackageUnitCommentEditorTool >> wantsTextStyling [
	^ false
]
