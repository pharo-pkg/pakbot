Class {
	#name : #PBIcebergIntegrationTest,
	#superclass : #TestCase,
	#instVars : [
		'location',
		'projectName',
		'repository',
		'browser'
	],
	#category : #'CargoPackageManager-UI-Tests'
}

{ #category : #utility }
PBIcebergIntegrationTest >> openIcebergAndGetPakbotMenu [
	| repositoryDataSource repositoryIndex menu |
	browser := IceTipRepositoriesBrowser new 
		openWithSpec;
		yourself.
	repositoryDataSource := browser repositoryList adapter widget dataSource.
	repositoryIndex := repositoryDataSource elements detectIndex: [:repo | repo realObject entity == repository ].
	browser repositoryList clickItem: repositoryIndex.
	menu := repositoryDataSource menuColumn: 1 row: repositoryIndex.
	menu instVarNamed: 'owner' put: browser repositoryList adapter widget.
	
	"(menu itemWithWording: 'Pakbot') select: (MouseMoveEvent new instVarNamed: 'source' put: World hands first; yourself)."
	^ menu itemWithWording: 'Pakbot'.
]

{ #category : #running }
PBIcebergIntegrationTest >> setUp [
	super setUp.
	location := '/foo'.
	projectName := 'test-project'.
	
	repository := PBIceMemoryRepository new.
	repository 
		name: projectName;
		location: location.
	PBTestIcebergWorkingCopy repository: repository.
	repository fileSystem ensureCreateDirectory: location.

	
]

{ #category : #running }
PBIcebergIntegrationTest >> tearDown [ 
	super tearDown.
	repository forget.
	browser ifNotNil: [ browser delete].
]

{ #category : #tests }
PBIcebergIntegrationTest >> testDisablePakbotIntegrationIsAvailableWhenRepositoryUsesPakbotProject [
	| pakbotMenuGroup menuItem |
	
	(repository repositoryDirectory / PBSourceRepository new projectMetadataFileName) ensureCreateFile.
	repository workingCopy basicSetProject: (PBIcebergProject onRepository: repository project: nil).
	self assert: (repository project isKindOf: PBIcebergProject).
	
	IceRepository registerRepository: repository.
	pakbotMenuGroup := self openIcebergAndGetPakbotMenu.
	
	self assert: pakbotMenuGroup notNil.
	menuItem := pakbotMenuGroup subMenu itemWithWording: 'Disable Packbot project integration'.	
	self assert: menuItem notNil.
	menuItem := pakbotMenuGroup subMenu itemWithWording: 'Enable Packbot project integration'.	
	self assert: menuItem isNil.
]

{ #category : #tests }
PBIcebergIntegrationTest >> testEnablePakbotIntegrationIsAvailableWhenRepositoryDoesNotUsePakbotProjectButMetadataIsAvailable [
	| pakbotMenuGroup menuItem |
	
	(repository repositoryDirectory / PBSourceRepository new projectMetadataFileName) ensureCreateFile.
	self deny: (repository project isKindOf: PBIcebergProject).
	
	IceRepository registerRepository: repository.
	pakbotMenuGroup := self openIcebergAndGetPakbotMenu.
	
	self assert: pakbotMenuGroup notNil.
	menuItem := pakbotMenuGroup subMenu itemWithWording: 'Enable Packbot project integration'.	
	self assert: menuItem notNil.
	menuItem := pakbotMenuGroup subMenu itemWithWording: 'Disable Packbot project integration'.	
	self assert: menuItem isNil.
]

{ #category : #tests }
PBIcebergIntegrationTest >> testPakbotIntegrationNotAvailableWhenRepositoryDoesNotHavePakbotMetadata [
	| pakbotMenuGroup |
	
	repository workingCopy basicSetProject: (IceBasicProject onRepository: repository).
	
	self assert: (repository project isKindOf: IceBasicProject).
	
	IceRepository registerRepository: repository.
	pakbotMenuGroup := self openIcebergAndGetPakbotMenu.
	
	self assert: pakbotMenuGroup isNil.
]
