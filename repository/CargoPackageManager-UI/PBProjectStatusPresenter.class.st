"
I am a component to be used to show the project status. 
With an icon, a button for an action and a short and long description.
"
Class {
	#name : #PBProjectStatusPresenter,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'statusLabel',
		'statusIcon',
		'actionButton'
	],
	#category : #'CargoPackageManager-UI'
}

{ #category : #specs }
PBProjectStatusPresenter class >> defaultSpec [
	<spec>

	^ SpBoxLayout newLeftToRight 
			add: #statusIcon expand: false;
			add: #statusLabel;
			add: #actionButton expand: false
]

{ #category : #examples }
PBProjectStatusPresenter class >> example [
	<example>
	
	^ (self on: PBProjectVersion example) 
		openWithSpec
]

{ #category : #specs }
PBProjectStatusPresenter class >> newOn: aProject owner: anOwner [.

	^ self basicNew
		project: aProject;
		owner: anOwner;
		initialize;
		yourself
]

{ #category : #initialization }
PBProjectStatusPresenter >> handleAnnouncement: ann [

	ann project = self project ifFalse: [ ^ self ].
	
	self needRebuild: false.
	owner refreshUI
]

{ #category : #initialization }
PBProjectStatusPresenter >> initializePresenter [
	
	SystemAnnouncer uniqueInstance weak
		when: CGOProjectAnnouncement
		send: #handleAnnouncement:
		to: self.
		
	actionButton action: [ (PBOpenRepairDialogAction onProject: self project) execute ]
]

{ #category : #initialization }
PBProjectStatusPresenter >> initializeWidgets [
	
	statusLabel := self newLabel.
	actionButton := self newButton label: 'Repair'.
	statusIcon := self newImage.
	
	statusIcon image: (self iconNamed: self project problemIcon).
	statusLabel label: self project problemShortDescription.
	statusLabel help: self project problemLongDescription.
	statusIcon help: self project problemLongDescription 

	

]

{ #category : #accessing }
PBProjectStatusPresenter >> project [
	^ self model
]

{ #category : #announcements }
PBProjectStatusPresenter >> unsubscribe [
	
	SystemAnnouncer uniqueInstance unsubscribe: self
]
