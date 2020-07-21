Class {
	#name : #PBPackageRepositoryTest,
	#superclass : #TestCase,
	#category : #'PakbotPackageManager-Repository-Tests'
}

{ #category : #tests }
PBPackageRepositoryTest >> tempIceRepository [
	"| fs |
	fs := FileSystem memory root.
	^ IceLibgitRepository new
		name: 'temp-git-repo';
		location: fs;
		init;
		yourself."
	^ PBGitRepository example
]

{ #category : #tests }
PBPackageRepositoryTest >> testCanCreateALocalRepository [
	| repository |
	repository := PBPackageRepository newLocalRepositoryIn: FileSystem memory root.
	
	self 
		assert: repository packages size 
		equals: 0
]

{ #category : #tests }
PBPackageRepositoryTest >> testCanFetchAProject [
	| repository project published |
	repository := PBPackageRepository newLocalRepositoryIn: FileSystem memory root.
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
PBPackageRepositoryTest >> testCanPublishAProject [ 
	| repository project published |
	repository := PBPackageRepository newLocalRepositoryIn: FileSystem memory root.
	project := PBProject example.
	project
		registry: PBPackageRegistry new;
		repository: 	PBGitRepository example;
		version: '0.1' asSemanticVersion;
		publishOn: repository.
	
	self 
		assert: repository packages size 
		equals: 1.
		
	published := repository fetch: project name version: project version.

	self
		assert: published name
		equals: project name.
	self
		assert: published version
		equals: project version.

	self 
		assert: published class
		equals: PBProject.
	self 
		assertCollection: published packageNames
		hasSameElements: #(#UnitTest)
]

{ #category : #tests }
PBPackageRepositoryTest >> testCannotPublishAProjectHavingNonFixedVersion [
	| repository project |
	repository := PBPackageRepository newLocalRepositoryIn: FileSystem memory root.
	project := PBProject example.
	project
		registry: PBPackageRegistry new;
		repository: 	PBGitRepository example.
	
	self 
		should: [ project publishOn: repository ]
		raise: PBPublicationError.
	
	self assert: repository packages isEmpty

]

{ #category : #tests }
PBPackageRepositoryTest >> testCannotPublishAProjectWhenHavingDependencyOnNonFixedVersion [
	self flag: 'TODO'.
	self skip

]

{ #category : #tests }
PBPackageRepositoryTest >> testCannotPublishAProjectWhenVersionAlreadyPublished [
	| repository project |
	repository := PBPackageRepository newLocalRepositoryIn: FileSystem memory root.
	project := PBProject example.
	project
		registry: PBPackageRegistry new;
		repository: 	PBGitRepository example;
		version: '0.1' asSemanticVersion;	
		publishOn: repository.
	
	self 
		assert: repository packages size 
		equals: 1.
		
	self
		should: [ project publishOn: repository ]
		raise: PBPublicationError
]

{ #category : #tests }
PBPackageRepositoryTest >> testCannotPublishAProjectWithNoRepository [ 
	| repository project |
	repository := PBPackageRepository newLocalRepositoryIn: FileSystem memory root.
	project := PBProject example.
	project 
		registry: PBPackageRegistry new;
		version: '0.1' asSemanticVersion.
	
	self 
		should: [ project publishOn: repository ]
		raise: PBError
		whoseDescriptionIncludes: 'no repository defined'
		description: 'Did not get right exception when trying to publish a project with no repository set'.

]

{ #category : #tests }
PBPackageRepositoryTest >> testProjectNotPublishedWhenAnErrorOccursDuringPublication [
	| repository project |
	repository := PBPackageRepository newLocalRepositoryIn: FileSystem memory root.
	project := PBProject example.
	project 
		registry: PBPackageRegistry new;
		repository: 	PBGitRepository example.
	
	self 
		should: [ project publishOn: repository ]
		raise: PBPublicationError
		whoseDescriptionIncludes: 'no version defined!'
		description: 'No error signaled when publishing a project with no fixed version'.
		
	self deny: (repository fileForPackageNamed: project name version: project version asString) exists

]

{ #category : #tests }
PBPackageRepositoryTest >> testPublishedProjectHasASourceRepository [
	| repository project fetchedProject |
	repository := PBPackageRepository
		newLocalRepositoryIn: FileSystem memory root.
	project := PBProject example.
	project
		registry: PBPackageRegistry new;
		repository: self tempIceRepository;
		version: '1.1';
		publishOn: repository.
	fetchedProject := repository
		fetch: project name
		version: project version.
	self assert: fetchedProject repository isValidRepository
]
