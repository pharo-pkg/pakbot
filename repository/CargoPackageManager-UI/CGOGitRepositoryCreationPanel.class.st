"
I'm in charge of creating a new Git repository and execute some actions onthe newly created repository.

I reuse Iceberg  UI to create new repositories and regiter to Iceberg announcer to act on the first  IceRepositoryCreated announcement.

You can try me with :
	self  withNewRepositoryDo: [: repo | repo inspect ]
"
Class {
	#name : #CGOGitRepositoryCreationPanel,
	#superclass : #ComposablePresenter,
	#instVars : [
		'newRepositoryButton',
		'cloneRepositoryButton',
		'addLocalRepositoryButton',
		'onNewRepositoryBlock'
	],
	#category : #'CargoPackageManager-UI'
}

{ #category : #specs }
CGOGitRepositoryCreationPanel class >> defaultSpec [
	^ SpecLayout composed
		newColumn: [ :column |
			column 
				add: #newRepositoryButton height: self toolbarHeight;
				add: #cloneRepositoryButton height: self toolbarHeight;
				add: #addLocalRepositoryButton height: self toolbarHeight ]
]

{ #category : #enumerating }
CGOGitRepositoryCreationPanel class >> withNewRepositoryDo: aBlock [
	self new
		onNewRepositoryBlock: aBlock; 
		openWithSpec
]

{ #category : #actions }
CGOGitRepositoryCreationPanel >> addLocalRepository [
	self flag: 'TODO'.
	"IceTipLocalRepositoryPanel ?"
	#IceImportLocalRepositoryModel new openWithSpec
]

{ #category : #accessing }
CGOGitRepositoryCreationPanel >> addLocalRepositoryButton [
	^ addLocalRepositoryButton
]

{ #category : #actions }
CGOGitRepositoryCreationPanel >> cloneRepository [
	self flag: 'TODO'.
	"IceTipGitProviderRepositoryPanel?"
	#IceCloneRepositoryModel new openWithSpec
]

{ #category : #accessing }
CGOGitRepositoryCreationPanel >> cloneRepositoryButton [
	^ cloneRepositoryButton
]

{ #category : #initialization }
CGOGitRepositoryCreationPanel >> initialExtent [
	 ^ (350.0@125.0)
]

{ #category : #initialization }
CGOGitRepositoryCreationPanel >> initializePresenter [
	super initializePresenter.

	newRepositoryButton action: [ self newRepository ].
	cloneRepositoryButton action: [ self cloneRepository; delete ].
	addLocalRepositoryButton action: [ self addLocalRepository; delete ].
	
	Iceberg announcer weak 
		when: IceRepositoryCreated 
		send: #newRepositoryCreated:
		to: self.
]

{ #category : #initialization }
CGOGitRepositoryCreationPanel >> initializeWidgets [
	newRepositoryButton := self newButton
		label: 'New repository';
		icon: (Smalltalk ui icons iconNamed: #smallNew);
		enabled: true.
	cloneRepositoryButton := self newButton
		label: 'Clone repository';
		icon: (Smalltalk ui icons iconNamed: #add);
		enabled: true.
	addLocalRepositoryButton := self newButton
		label: 'Add local repository';
		icon: (Smalltalk ui icons iconNamed: #packageAdd);
		enabled: true.

]

{ #category : #actions }
CGOGitRepositoryCreationPanel >> newRepository [
	IceTipNewRepositoryPanel new openWithSpec
]

{ #category : #accessing }
CGOGitRepositoryCreationPanel >> newRepositoryButton [
	^ newRepositoryButton
]

{ #category : #notifying }
CGOGitRepositoryCreationPanel >> newRepositoryCreated: anIceRepositoryCreatedAnnouncement [
	Iceberg announcer unsubscribe: self.
	onNewRepositoryBlock 
		value: (PBGitRepositoryCreator repositoryFromIceRepository: anIceRepositoryCreatedAnnouncement repository).
	self delete
]

{ #category : #accessing }
CGOGitRepositoryCreationPanel >> onNewRepositoryBlock: aBlockClosure [ 
	onNewRepositoryBlock := aBlockClosure
]

{ #category : #accessing }
CGOGitRepositoryCreationPanel >> title [
	^ 'Set Cargo project Git repository'
]
