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
	#category : #'Pakbot-Browser-Presenters'
}

{ #category : #examples }
PBProjectStatusPresenter class >> example [

	<example>
	^ (self on: PBProjectVersion example) open
]

{ #category : #initialization }
PBProjectStatusPresenter >> connectPresenters [
	
	Pakbot announcer weak
		when: PBProjectAnnouncement
		send: #handleAnnouncement:
		to: self.
		
	actionButton action: [ (PBRepairProjectCommand forSpecContext: self mainPresenter) execute ]
]

{ #category : #layout }
PBProjectStatusPresenter >> defaultLayout [
	<spec>

	^ SpBoxLayout newLeftToRight 
			add: statusIcon expand: false;
			add: statusLabel;
			add: actionButton expand: false
]

{ #category : #private }
PBProjectStatusPresenter >> delete [
	super delete.
	self unsubscribe
]

{ #category : #initialization }
PBProjectStatusPresenter >> handleAnnouncement: ann [

	ann project = self project ifFalse: [ ^ self ].
	
	owner refreshUI
]

{ #category : #initialization }
PBProjectStatusPresenter >> initializePresenters [
	
	statusLabel := self newLabel.
	actionButton := self newButton label: 'Repair'.
	statusIcon := self newImage.
	
	self project ifNil: [ ^ self ].
	statusIcon image: (self iconNamed: self project problemIcon).
	statusLabel label: self project problemShortDescription.
	statusLabel help: self project problemLongDescription.
	statusIcon help: self project problemLongDescription 

	

]

{ #category : #accessing }
PBProjectStatusPresenter >> mainPresenter [
	"Main presenter -> Project presenter -> Status presenter"
	^ self owner owner
]

{ #category : #accessing }
PBProjectStatusPresenter >> project [
	^ self model
]

{ #category : #announcements }
PBProjectStatusPresenter >> unsubscribe [
	
	Pakbot announcer unsubscribe: self
]
