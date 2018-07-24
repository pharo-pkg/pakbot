Class {
	#name : #PBRepositoryInputField,
	#superclass : #ComposablePresenter,
	#instVars : [
		'iconContainerPanel',
		'label',
		'button',
		'project'
	],
	#category : #'CargoPackageManager-UI'
}

{ #category : #specs }
PBRepositoryInputField class >> defaultSpec [
	<spec: #default>
	
	^ SpecLayout composed 
		newRow: [ :column |
			column 
				newColumn: #iconContainerPanel width: self buttonWidth / 3;
				newColumn: #label;
				newColumn: #button width: self buttonWidth ]
]

{ #category : #accessing }
PBRepositoryInputField >> button [
	^ button
]

{ #category : #accessing }
PBRepositoryInputField >> button: anObject [
	button := anObject
]

{ #category : #accessing }
PBRepositoryInputField >> iconContainerPanel [
	^ iconContainerPanel
]

{ #category : #accessing }
PBRepositoryInputField >> iconContainerPanel: anObject [
	iconContainerPanel := anObject
]

{ #category : #initialization }
PBRepositoryInputField >> initializePresenter [
	
	button action: [ 
		(PBOpenNewRepositoryDialogAction onProject: project)
			acceptCallback: [ self refresh ];
			execute ].
	self refresh.
]

{ #category : #initialization }
PBRepositoryInputField >> initializeWidgets [
	
	iconContainerPanel := self newPanel.
	label := self newLabel.
	button := self newButton.
]

{ #category : #accessing }
PBRepositoryInputField >> label [
	^ label
]

{ #category : #accessing }
PBRepositoryInputField >> label: anObject [
	label := anObject
]

{ #category : #initialization }
PBRepositoryInputField >> refresh [
	
	iconContainerPanel widget removeAllMorphs.
	iconContainerPanel widget addMorphBack: 
		((self iconNamed: project repository iconName) asMorph
			hResizing: #spaceFill;
			vResizing: #spaceFill).
	label label: project repository description.
	
	button iconName: project repository editionIconName.
]

{ #category : #accessing }
PBRepositoryInputField >> setModelBeforeInitialization: aProject [

	project := aProject
]
