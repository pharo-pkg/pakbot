"
I am a component to be used to show the project status. 
With an icon, a button for an action and a short and long description.
"
Class {
	#name : #CGOProjectStatusPresenter,
	#superclass : #ComposablePresenter,
	#instVars : [
		'project',
		'statusLabel',
		'statusIcon',
		'actionButton'
	],
	#category : 'CargoPackageManager-UI'
}

{ #category : #specs }
CGOProjectStatusPresenter class >> defaultSpec [
	<spec>

	^ SpecLayout composed
		newRow: [ :row |
			row 
				add: #statusIcon width: 16;
				add: #statusLabel;
				add: #actionButton width: 60 ]
]

{ #category : #specs }
CGOProjectStatusPresenter class >> newOn: aProject owner: anOwner. [

	^ self basicNew
		project: aProject;
		owner: anOwner;
		initialize;
		yourself
]

{ #category : #accessing }
CGOProjectStatusPresenter >> actionButton [

	^ actionButton
]

{ #category : #initialization }
CGOProjectStatusPresenter >> handleAnnouncement: ann [

	ann project = self project
		ifTrue: [ 
			self needRebuild: false.
			owner refreshUI ]
]

{ #category : #initialization }
CGOProjectStatusPresenter >> initializePresenter [
	
	SystemAnnouncer uniqueInstance weak
		when: CGOProjectAnnouncement
		send: #handleAnnouncement:
		to: self.
		
	actionButton action: [ (CGOOpenRepairDialog onProject: project) execute ]
]

{ #category : #initialization }
CGOProjectStatusPresenter >> initializeWidgets [
	
	statusLabel := self newLabel.
	actionButton := self newButton label: 'Repair'.
	statusIcon := self newImage.
	
	statusIcon image: (self iconNamed: project problemIcon).
	statusLabel label: project problemShortDescription.
	statusLabel help: project problemLongDescription.
	statusIcon help: project problemLongDescription 

	

]

{ #category : #accessing }
CGOProjectStatusPresenter >> project [
	^ project
]

{ #category : #accessing }
CGOProjectStatusPresenter >> project: aProject [ 
	
	project := aProject.


]

{ #category : #accessing }
CGOProjectStatusPresenter >> requiredHeight [
	
	^ project hasProblems ifTrue: [ 30 ] ifFalse: [ 0 ]
]

{ #category : #accessing }
CGOProjectStatusPresenter >> statusIcon [
	^ statusIcon
]

{ #category : #accessing }
CGOProjectStatusPresenter >> statusLabel [
	^ statusLabel
]
