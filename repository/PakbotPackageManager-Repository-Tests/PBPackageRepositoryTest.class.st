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
	^ CGOGitRepository example
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
		repository: 	CGOGitRepository example;
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
		repository: 	CGOGitRepository example;
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
PBPackageRepositoryTest >> testCannotPublishAProjectWhenHavingDependencyOnNonFixedVersion [
	self flag: 'TODO'.
	self skip

]

{ #category : #tests }
PBPackageRepositoryTest >> testCannotPublishAProjectWhenVersionAlreadyPublished [
	| repository project published |
	repository := PBPackageRepository newLocalRepositoryIn: FileSystem memory root.
	project := PBProject example.
	project
		registry: PBPackageRegistry new;
		repository: 	CGOGitRepository example;
		publishOn: repository.
	
	self 
		assert: repository packages size 
		equals: 1.
		
	self
		should: [ project publishOn: repository ]
		raise: CGOPackageVersionAlreadyExistsError
]

{ #category : #tests }
PBPackageRepositoryTest >> testCannotPublishAProjectWithNoRepository [ 
	| repository project |
	repository := PBPackageRepository newLocalRepositoryIn: FileSystem memory root.
	project := PBProject example.
	project registry: PBPackageRegistry new.
	
	self 
		should: [ project publishOn: repository ]
		raise: PBError
]

{ #category : #tests }
PBPackageRepositoryTest >> testProjectNotPublishedWhenAnErrorOccursDuringPublication [
	| repository project |
	repository := PBPackageRepository newLocalRepositoryIn: FileSystem memory root.
	project := PBProject example.
	project registry: PBPackageRegistry new.
	
	self 
		should: [ project publishOn: repository ]
		raise: PBError.
		
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
