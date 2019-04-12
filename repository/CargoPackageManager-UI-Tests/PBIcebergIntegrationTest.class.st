Class {
	#name : #PBIcebergIntegrationTest,
	#superclass : #TestCase,
	#instVars : [
		'location',
		'projectName',
		'repository'
	],
	#category : #'CargoPackageManager-UI-Tests'
}

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
	repository forget
]

{ #category : #tests }
PBIcebergIntegrationTest >> testDisablePakbotIntegrationIsAvailableWhenRepositoryUsesPakbotProject [
	| browser repositoryDataSource repositoryIndex menu menuGroupItem menuItem |
	
	(repository repositoryDirectory / PBSourceRepository new projectMetadataFileName) ensureCreateFile.
	repository workingCopy basicSetProject: (PBIcebergProject onRepository: repository project: nil).
	
	self assert: (repository project isKindOf: PBIcebergProject).
	
	IceRepository registerRepository: repository.

	browser := IceTipRepositoriesBrowser new 
		openWithSpec;
		yourself.
	repositoryDataSource := browser repositoryList widget dataSource.
	repositoryIndex := repositoryDataSource elements detectIndex: [:repo | repo realObject entity == repository ].
	menu := repositoryDataSource menuColumn: 1 row: repositoryIndex.
	menu instVarNamed: 'owner' put: browser repositoryList widget.
	"(menu itemWithWording: 'Pakbot') select: (MouseMoveEvent new instVarNamed: 'source' put: World hands first; yourself)."

	menuGroupItem := menu itemWithWording: 'Pakbot'.
	self assert: menuGroupItem notNil.

	menuItem := menuGroupItem subMenu itemWithWording: 'Disable Packbot project integration'.	
	self assert: menuItem notNil.
	menuItem := menuGroupItem subMenu itemWithWording: 'Enable Packbot project integration'.	
	self assert: menuItem isNil.
	
	browser delete.
]

{ #category : #tests }
PBIcebergIntegrationTest >> testEnablePakbotIntegrationIsAvailableWhenRepositoryDoesNotUsePakbotProjectButMetadataIsAvailable [
	| browser repositoryDataSource repositoryIndex menu menuGroupItem menuItem |
	
	(repository repositoryDirectory / PBSourceRepository new projectMetadataFileName) ensureCreateFile.
	
	self deny: (repository project isKindOf: PBIcebergProject).
	
	IceRepository registerRepository: repository.

	browser := IceTipRepositoriesBrowser new 
		openWithSpec;
		yourself.
	repositoryDataSource := browser repositoryList widget dataSource.
	repositoryIndex := repositoryDataSource elements detectIndex: [:repo | repo realObject entity == repository ].
	menu := repositoryDataSource menuColumn: 1 row: repositoryIndex.
	menu instVarNamed: 'owner' put: browser repositoryList widget.

	menuGroupItem := menu itemWithWording: 'Pakbot'.
	self assert: menuGroupItem notNil.

	menuItem := menuGroupItem subMenu itemWithWording: 'Enable Packbot project integration'.	
	self assert: menuItem notNil.
	menuItem := menuGroupItem subMenu itemWithWording: 'Disable Packbot project integration'.	
	self assert: menuItem isNil.
	
	browser delete.
]

{ #category : #tests }
PBIcebergIntegrationTest >> testPakbotIntegrationNotAvailableWhenRepositoryDoesNotHavePakbotMetadata [
	| browser repositoryDataSource repositoryIndex menu menuGroupItem |
	
	repository workingCopy basicSetProject: (IceBasicProject onRepository: repository).
	
	self assert: (repository project isKindOf: IceBasicProject).
	
	IceRepository registerRepository: repository.

	browser := IceTipRepositoriesBrowser new 
		openWithSpec;
		yourself.
	repositoryDataSource := browser repositoryList widget dataSource.
	repositoryIndex := repositoryDataSource elements detectIndex: [:repo | repo realObject entity == repository ].
	menu := repositoryDataSource menuColumn: 1 row: repositoryIndex.
	menu instVarNamed: 'owner' put: browser repositoryList widget.
	
	menuGroupItem := menu itemWithWording: 'Pakbot'.
	self assert: menuGroupItem isNil.

	browser delete.
]
