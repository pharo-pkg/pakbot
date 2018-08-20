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
			repository := selectedPanel accept.
			project project addIcebergRepository: repository.
			acceptCallback value ]
		onCancel: [  ]
]

{ #category : #execution }
PBOpenNewRepositoryDialogAction >> project: aProject [
	project := aProject
]
