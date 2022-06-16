Class {
	#name : #PBGitBasedPackageRepositoryTest,
	#superclass : #PBTestCaseWithGitCredentials,
	#instVars : [
		'tempFolder',
		'tempFolder2'
	],
	#category : #'PakbotPackageManager-Repository-Tests'
}

{ #category : #utils }
PBGitBasedPackageRepositoryTest >> newLocalPBGitBasedPackageRepository [
	| repository |
	repository := PBGitBasedPackageRepository
		newEmptyLocalRepositoryIn: tempFolder.
	(repository iceRepository getConfigurationGlobal: false)
		username: 'unit tester';
		email: 'test@nowhere.com'.
	^ repository
]

{ #category : #running }
PBGitBasedPackageRepositoryTest >> setUp [
	| baseFolderName |
	super setUp.
	
	baseFolderName := 'pharo-tests-PBGitBasedPkgRepo-', DateAndTime now asFileNameCompatibleString.
	tempFolder := FileLocator temp	/ baseFolderName.
	tempFolder2 := FileLocator temp	/ (baseFolderName , '-2').

]

{ #category : #running }
PBGitBasedPackageRepositoryTest >> tearDown [ 
	tempFolder ifExists: [ :folder | folder ensureDeleteAll ].
	tempFolder2 ifExists: [ :folder | folder ensureDeleteAll ].
	
	super tearDown.
]

{ #category : #tests }
PBGitBasedPackageRepositoryTest >> testCanCreateALocalCloneOfPackageRepository [
	| repository |
	
	repository := PBGitBasedPackageRepository newLocalRepositoryIn: tempFolder.
	(repository iceRepository remoteBranchNamed: 'origin/empty-repo') checkout.
	
	self assert: repository packages size equals: 0
]

{ #category : #tests }
PBGitBasedPackageRepositoryTest >> testCanFetchAProject [
	| repository project published |
	repository := self newLocalPBGitBasedPackageRepository.
	project := PBProjectVersion example.
	project 
		version: '1.0' asSemanticVersion;
		registry: PBPackageRegistry new;
		repository: 	PBGitRepository example;
		publishOn: repository.
	
	published := repository fetch: project name version: project version.

	self
		assert: published name
		equals: project name.
	self
		assert: published version
		equals: project version.
]

{ #category : #tests }
PBGitBasedPackageRepositoryTest >> testCanPublishAProject [
	| repository project published |
	repository := self newLocalPBGitBasedPackageRepository.
	project := PBProjectVersion example.
	
	project
		registry: PBPackageRegistry new;
		repository: PBGitRepository example;
		version: '0.1' asSemanticVersion;
		publishOn: repository.
		
	self assert: repository packages size equals: 1.
	self
		assertCollection: repository packages
		hasSameElements: repository head fileSystem directoryNames.
		
	published := repository fetch: project name version: project version.
	
	self assert: published name equals: project name.
	self assert: published version equals: project version.
	self assert: published class equals: PBProjectVersion.
	self
		assertCollection: published packageNames
		hasSameElements: #(#UnitTest)
]

{ #category : #tests }
PBGitBasedPackageRepositoryTest >> testCannotPublishedIfAlreadyPublished [
	| repository project |
	repository := self newLocalPBGitBasedPackageRepository.
	project := PBProjectVersion example.

	project
		registry: PBPackageRegistry new;
		repository: PBGitRepository example;
		version: '0.1' asSemanticVersion.
	project publishOn: repository.
	
	self
		should: [ project publishOn: repository ]
		raise: PBPublicationError
		whoseDescriptionIncludes: ' has already been published'
		description: 'Cannot publish a project if version is already published'
	
]

{ #category : #tests }
PBGitBasedPackageRepositoryTest >> testPublishedProjectIsTagged [
	| packageRepository project repository |
	packageRepository := self newLocalPBGitBasedPackageRepository.
	project := PBProjectVersion example.
	repository := PBGitRepository repository: packageRepository iceRepository.
	repository iceRepository commitWithMessage: 'initial commit'.

	project
		registry: PBPackageRegistry new;
		repository: repository;
		version: '0.1' asSemanticVersion;
		publishOn: packageRepository.
		
	self 
		assert: project repository iceRepository tags size 
		equals: 1.
	self 
		assert: project repository iceRepository tags first name
		equals: '0.1.0'.
]
