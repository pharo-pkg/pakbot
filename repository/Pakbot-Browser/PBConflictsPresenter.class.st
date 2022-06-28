"
I list all conflicts for a resolution and propose a way to choose how to solve these conflicts.
"
Class {
	#name : #PBConflictsPresenter,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'conflictsList'
	],
	#category : #'Pakbot-Browser-Presenters'
}

{ #category : #examples }
PBConflictsPresenter class >> example [
	<example>

	(self on: PBResolutionPresenter conflictingResolutionExample) open
]

{ #category : #accessing }
PBConflictsPresenter >> conflicts [
	^ self resolution conflicts
]

{ #category : #layout }
PBConflictsPresenter >> defaultLayout [ 
	
	^ SpBoxLayout newTopToBottom
		add: #conflictsList;
		yourself
]

{ #category : #testing }
PBConflictsPresenter >> hasConflicts [

	^ self conflicts anySatisfy: [ :each | each isResolved not ]
]

{ #category : #initialization }
PBConflictsPresenter >> initializePresenters [ 
	conflictsList := self newTable
		addColumn: (SpStringTableColumn title: 'Project Name' evaluated: #projectName);
		addColumn:
			((SpDropListTableColumn 
				title: 'Version to use' 
				evaluated: [ :conflict | conflict possibleVersions ])
			selectedItemChangedAction: [ :conflict :version | 
				conflict selectResolutionFromVersion: version.
				self updateOkButtonAndResolution ];
			yourself);
		items: self conflicts;
		addColumn: (SpStringTableColumn title: 'Details' evaluated: #resolutionDetailText);
		beResizable;
		yourself.
]

{ #category : #accessing }
PBConflictsPresenter >> resolution [
	
	^ self model
]

{ #category : #updating }
PBConflictsPresenter >> updateOkButtonAndResolution [

	self owner ifNotNil: [ 
		self owner
			updateOkButton;
			updateResolutionPresenter ]
]
