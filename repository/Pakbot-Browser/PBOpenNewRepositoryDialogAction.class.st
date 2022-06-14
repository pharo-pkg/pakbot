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
	
	^ SpOptionListPresenter new
		addOptions: {PBImportIcebergRepositoryPanel new} , IceTipRepositoryTypePanel allTypes;
		acceptCallback: [ :selectedOption | | repository |
			selectedOption validate.
			repository := PBGitRepository repository: selectedOption newRepository.
			project project repository: repository.
			
			repository iceRepository workingCopy basicSetProject: (PBIcebergProject onRepository: repository iceRepository project: project project).
			self doPostAction ];
		openDialog;
		yourself
]

{ #category : #execution }
PBOpenNewRepositoryDialogAction >> doPostAction [
	postActionCallback value
]

{ #category : #execution }
PBOpenNewRepositoryDialogAction >> postActionCallback: aCallback [

	postActionCallback := aCallback	
]