"
Dialog box displaying both current resolution and potential conflits.
After conflicts are solved, proceed to the load action.
"
Class {
	#name : #PBLoadPreviewDialog,
	#superclass : #ComposablePresenter,
	#instVars : [
		'resolutionPanel',
		'conflictsPanel',
		'resolution',
		'conflictsLabel',
		'resolutionLabel'
	],
	#category : #'CargoPackageManager-UI-Loading'
}

{ #category : #specs }
PBLoadPreviewDialog class >> defaultSpec [
	^ SpecLayout composed
		newColumn: [ :col | 
			col
				newRow: [ :row |
					row
						add: #resolutionLabel;
						add: #conflictsLabel ]
					height: self inputTextHeight;
				newRow: [ :row |
					row
						add: #resolutionPanel;
						addSplitter;
						add: #conflictsPanel;
						yourself ] ]
]

{ #category : #examples }
PBLoadPreviewDialog class >> example [
	<example>

	| resolution |

	resolution := (PBPackageRegistry default projectNamed: #PharoLauncher) resolve.
	(self on: resolution) openDialogWithSpec
]

{ #category : #action }
PBLoadPreviewDialog >> accept [
	conflictsPanel accept.
	resolution load
	
]

{ #category : #accessing }
PBLoadPreviewDialog >> conflictsLabel [
	^ conflictsLabel
]

{ #category : #accessing }
PBLoadPreviewDialog >> conflictsPanel [
	^ conflictsPanel
]

{ #category : #initialization }
PBLoadPreviewDialog >> initialExtent [
	^ (750@450)
]

{ #category : #initialization }
PBLoadPreviewDialog >> initializeWidgets [
	
	conflictsLabel := self newLabel label: 'Conflicts to solve'.
	conflictsPanel := PBResolveConflictsPanel onResolution: resolution owner: self.
	resolutionLabel := self newLabel label: 'Dependency resolution'.
	resolutionPanel := PBResolutionPanel owner: self on: resolution.
	
	self whenWindowChanged: [ self updateOkButton ].
]

{ #category : #opening }
PBLoadPreviewDialog >> openDialogWithSpec [

	^ super openDialogWithSpec
		okAction: [ self accept ];
		yourself
]

{ #category : #accessing }
PBLoadPreviewDialog >> resolutionLabel [
	^ resolutionLabel
]

{ #category : #accessing }
PBLoadPreviewDialog >> resolutionPanel [
	^ resolutionPanel
]

{ #category : #'model access' }
PBLoadPreviewDialog >> setModelBeforeInitialization: aModel [

	resolution := aModel
]

{ #category : #accessing }
PBLoadPreviewDialog >> title [
	^ 'Load Preview'
]

{ #category : #updating }
PBLoadPreviewDialog >> updateOkButton [
	^ conflictsPanel hasConflicts
		ifTrue: [ self window toolbar okButton disable ]
		ifFalse: [ self window toolbar okButton enable ]
]

{ #category : #updating }
PBLoadPreviewDialog >> updateResolutionTable [
	resolutionPanel updateResolutionTree
]
