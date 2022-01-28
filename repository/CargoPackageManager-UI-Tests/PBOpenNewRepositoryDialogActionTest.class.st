Class {
	#name : #PBOpenNewRepositoryDialogActionTest,
	#superclass : #TestCase,
	#instVars : [
		'tempFolder',
		'counterIceRepository',
		'presenter'
	],
	#category : #'CargoPackageManager-UI-Tests'
}

{ #category : #running }
PBOpenNewRepositoryDialogActionTest >> tearDown [ 
	tempFolder ifNotNil: [ tempFolder ensureDeleteAll ].
	counterIceRepository ifNotNil: [ counterIceRepository forget ].
	presenter ifNotNil: [ presenter delete ].
]

{ #category : #tests }
PBOpenNewRepositoryDialogActionTest >> testCanCreateNewProject [
	| presenter newRepositoryPresenter project |

	project := PBProjectVersion named: ''.
	presenter := (PBOpenNewRepositoryDialogAction onProject: project) execute.
	presenter selectOptionAt: 2. "select new repository panel"
	self 
		assert: presenter selectedOption class
		equals: IceTipNewRepositoryPanel.
		
	newRepositoryPresenter := presenter selectedOption.
	newRepositoryPresenter projectNameInputText text: 'foo'.
	newRepositoryPresenter projectLocation location ensureDeleteAll.
	
	self deny: project repository isValidRepository.
	presenter doAccept.
	presenter delete.
	self assert: project repository isValidRepository.
	self 
		assert: project repository class
		equals: PBGitRepository.
	self assert: project repository iceRepository isValid.
	self 
		assert: project repository iceRepository name
		equals: 'foo'.
]

{ #category : #tests }
PBOpenNewRepositoryDialogActionTest >> testCanImportProject [
	| importRepositoryPresenter project iceRepository projectName |

	projectName := 'pakbot-testCanImportProject'.
	tempFolder := FileLocator temp / projectName.
	counterIceRepository := (IceRepositoryCreator new 
		location: tempFolder;
		remote: (IceGitRemote url: 'https://github.com/pharo-pkg/pharo-counter.git');
		createRepository)
	register;
	yourself. 
	
	project := PBProjectVersion named: projectName.
	presenter := (PBOpenNewRepositoryDialogAction onProject: project) execute.
	self 
		assert: presenter selectedOption class
		equals: PBImportIcebergRepositoryPanel.
		
	importRepositoryPresenter := presenter selectedOption.
	iceRepository := importRepositoryPresenter repositoryList items detect: [ :repo | repo name = projectName ].
	importRepositoryPresenter repositoryList selectItem: iceRepository.
	
	self deny: project repository isValidRepository.
	presenter doAccept.
	presenter delete.
	self assert: project repository isValidRepository.
	self 
		assert: project repository class
		equals: PBGitRepository.
	self assert: project repository iceRepository isValid.
	self 
		assert: project repository iceRepository
		equals: iceRepository.

	tempFolder ensureDeleteAll.
]
