Class {
	#name : #PBOpenNewRepositoryDialogAction,
	#superclass : #PBAbstractAction,
	#instVars : [
		'project',
		'acceptCallback'
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
	
	ITOptionDialog basicNew
		panels: {PBImportIcebergRepositoryPanel new} , IceTipRepositoryTypePanel allTypes;
		initialize;
		openDialogOnAccept: [ :selectedPanel | | repository |
			repository := CGOGitRepository repository: selectedPanel accept.
			project project repository: repository.
			
			repository iceRepository workingCopy basicSetProject: (PBIcebergProject onRepository: repository iceRepository project: project project).
			acceptCallback value ]
		onCancel: [  ]
]

{ #category : #execution }
PBOpenNewRepositoryDialogAction >> project: aProject [
	project := aProject
]
