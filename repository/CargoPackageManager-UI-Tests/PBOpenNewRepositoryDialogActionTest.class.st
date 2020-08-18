Class {
	#name : #PBOpenNewRepositoryDialogActionTest,
	#superclass : #TestCase,
	#instVars : [
		'tempFolder',
		'counterIceRepository'
	],
	#category : #'CargoPackageManager-UI-Tests'
}

{ #category : #running }
PBOpenNewRepositoryDialogActionTest >> tearDown [ 
	tempFolder ifNotNil: [ tempFolder ensureDeleteAll ].
	counterIceRepository ifNotNil: [ counterIceRepository forget ].
]

{ #category : #tests }
PBOpenNewRepositoryDialogActionTest >> testCanCreateNewProject [
	| presenter newRepositoryPresenter project |

	project := PBProjectVersion named: ''.
	presenter := (PBOpenNewRepositoryDialogAction onProject: project) execute.
	presenter selectionChanged: (FTSelectionChanged from: #(1) to: #(2)). "select new repository panel"
	self 
		assert: presenter selectedType class
		equals: IceTipNewRepositoryPanel.
		
	newRepositoryPresenter := presenter selectedType.
	newRepositoryPresenter projectNameInputText text: 'foo'.
	newRepositoryPresenter projectLocation location ensureDeleteAll.
	
	self deny: project repository isValidRepository.
	presenter accept.
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
	| presenter importRepositoryPresenter project iceRepository projectName |

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
		assert: presenter selectedType class
		equals: PBImportIcebergRepositoryPanel.
		
	importRepositoryPresenter := presenter selectedType.
	iceRepository := importRepositoryPresenter repositoryList listItems detect: [ :repo | repo name = projectName ].
	importRepositoryPresenter repositoryList setSelectedItem: iceRepository.
	
	self deny: project repository isValidRepository.
	presenter accept.
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
