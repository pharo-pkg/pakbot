Class {
	#name : #PBOpenNewRepositoryDialogAction,
	#superclass : #PBAbstractAction,
	#instVars : [
		'project',
		'acceptCallback',
		'dialog'
	],
	#category : #'CargoPackageManager-UI-Actions'
}

{ #category : #'instance-creation' }
PBOpenNewRepositoryDialogAction class >> onProject: aProject [

	^ self new
		project: aProject;
		yourself
]

{ #category : #execution }
PBOpenNewRepositoryDialogAction >> acceptCallback: aCallback [

	acceptCallback := aCallback	
]

{ #category : #execution }
PBOpenNewRepositoryDialogAction >> doExecute [
	
	dialog := ITOptionDialog basicNew
		panels: {PBImportIcebergRepositoryPanel new} , IceTipRepositoryTypePanel allTypes;
		initialize;
		openDialogOnAccept: [ :selectedPanel | | repository |
			dialog selectedType validate.
			repository := CGOGitRepository repository: dialog selectedType newRepository.
			project project repository: repository.
			
			repository iceRepository workingCopy basicSetProject: (PBIcebergProject onRepository: repository iceRepository project: project project).
			acceptCallback value ]
		onCancel: [  ];
		yourself.
]

{ #category : #execution }
PBOpenNewRepositoryDialogAction >> project: aProject [
	project := aProject
]
