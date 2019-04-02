Class {
	#name : #PBGitBasedPackageRepositoryTest,
	#superclass : #TestCase,
	#category : #'PakbotPackageManager-Repository-Tests'
}

{ #category : #utils }
PBGitBasedPackageRepositoryTest >> newLocalPBGitBasedPackageRepository [
	| repository |
	repository := PBGitBasedPackageRepository
		newLocalRepositoryIn: self tempFolder.
	(repository iceRepository getConfigurationGlobal: false)
		username: 'unit tester';
		email: 'test@nowhere.com'.
	^ repository
]

{ #category : #utils }
PBGitBasedPackageRepositoryTest >> tempFolder [
	^ FileLocator temp	/
			('pharo-tests-PBGitBasedPkgRepo-', DateAndTime now asFileNameCompatibleString).

]

{ #category : #tests }
PBGitBasedPackageRepositoryTest >> testCanCreateALocalRepository [
	| repository |
	
	repository := PBGitBasedPackageRepository newLocalRepositoryIn: self tempFolder.
	
	self assert: repository packages size equals: 0
]

{ #category : #tests }
PBGitBasedPackageRepositoryTest >> testCanFetchAProject [
	| repository project published |
	repository := self newLocalPBGitBasedPackageRepository.
	project := PBProject example.
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
	project := PBProject example.
	
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
	self assert: published class equals: PBProject.
	self
		assertCollection: published packageNames
		hasSameElements: #(#UnitTest)
]

{ #category : #tests }
PBGitBasedPackageRepositoryTest >> testCannotPublishedIfTagAlreadyExists [
	| repository project |
	repository := self newLocalPBGitBasedPackageRepository.
	repository iceRepository createTag: '0.1'.
	project := PBProject example.

	project
		registry: PBPackageRegistry new;
		repository: PBGitRepository example;
		version: '0.1' asSemanticVersion.
	
	self
		should: [ project publishOn: repository ]
		raise: PBPublicationError
		whoseDescriptionIncludes: ' has already been tagged'
		description: 'Cannot publish a project if version is already tagged'
	
]

{ #category : #tests }
PBGitBasedPackageRepositoryTest >> testPublishedProjectIsTagged [
	| repository project |
	repository := self newLocalPBGitBasedPackageRepository.
	project := PBProject example.
	
	project
		registry: PBPackageRegistry new;
		repository: PBGitRepository example;
		version: '0.1' asSemanticVersion;
		publishOn: repository.
		
	self 
		assert: project repository iceRepository tags size 
		equals: 1.
	self 
		assert: project repository iceRepository tags first name
		equals: '0.1.0'.
]
