"
I open a repository dialog so that the user can choose to import an exisitng iceberg repository or define a new one.
Once creeated, I will set the Iceberg project and the project repository
"
Class {
	#name : #PBOpenNewRepositoryDialogAction,
	#superclass : #PBAbstractAction,
	#instVars : [
		'postActionCallback'
	],
	#category : #'Pakbot-Browser-Actions'
}

{ #category : #'instance-creation' }
PBOpenNewRepositoryDialogAction class >> onProject: aProject [

	^ self new
		project: aProject;
		yourself
]

{ #category : #execution }
PBOpenNewRepositoryDialogAction >> doExecute [
	
	| presenter |
	presenter := SpOptionListPresenter new
		addOptions: {PBImportIcebergRepositoryPresenter new} , IceTipRepositoryTypePanel allTypes;
		whenAcceptedDo: [ :selectedOption | | repository |
			selectedOption validate.
			repository := PBGitRepository repository: selectedOption newRepository.
			self project repository: repository.
			self doPostAction ].
	presenter openDialog 
		title: 'Set up project repository';
		extent: 700@300.
	^ presenter
]

{ #category : #execution }
PBOpenNewRepositoryDialogAction >> doPostAction [
	postActionCallback value
]

{ #category : #execution }
PBOpenNewRepositoryDialogAction >> postActionCallback: aCallback [

	postActionCallback := aCallback	
]
