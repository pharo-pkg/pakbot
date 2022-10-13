Class {
	#name : #PBProjectCreationTest,
	#superclass : #PBTest,
	#instVars : [
		'project',
		'workDir'
	],
	#category : #'Pakbot-Tests-API'
}

{ #category : #running }
PBProjectCreationTest >> setUp [
	super setUp.
	
	registry systemPackageOrganizer: RPackageOrganizer new.
	project := registry newProjectNamed: #Counter.
	project version: '0.1-dev'.
	
	workDir := FileLocator temp / (self class name , Date today yyyymmdd, '-', (Time now print24 replaceAll: $: with: $-))

]

{ #category : #running }
PBProjectCreationTest >> tearDown [ 

	workDir ensureDeleteAll.
	super tearDown
]

{ #category : #tests }
PBProjectCreationTest >> testCanAddExternalDependency [

	| dependency |
	dependency := PBPakbotProjectDependency 
		named: 'pharo-counter' 
		repositoryUrl: 'https://git@github.com/demarey/pharo-counter-ui.git'
		version: 'master'.

	project addExternalProjectRequirement: dependency.
	
	self 
		assert: project dependencies size
		equals: 1.
		
	self 
		assert: project dependencies first
		equals: dependency.
]

{ #category : #tests }
PBProjectCreationTest >> testCanCommitAProject [

	"Commit action uses Iceberg that is only available in UI mode to review changes."
	
	| repository presenter changes |
	repository := PBGitRepositoryCreator new 
		location: workDir;
		createNewRepositoryNamed: 'tmp'.
	project repository: repository.
	
	presenter := (IceTipCommitBrowser onRepository: project repository iceRepository).
	changes := presenter diffPanel model tree children.
	
	self assert: changes size equals: 3.
	self assert: changes last key equals: repository projectMetadataFileName
]

{ #category : #tests }
PBProjectCreationTest >> testCanCreateAProject [

	project := (PBProjectVersion named: #'Counter')
		version: '0.1-dev';
		description: 'A simple counter project. You can increment it, decrement it and get the value from the counter.'
		yourself.
	
	
	self assert: project version minor equals: 1.
	self assert: project name equals: #Counter
]

{ #category : #tests }
PBProjectCreationTest >> testCanCreatePackageInProjectAndSetDescription [

	| description package |
	description := 'Foo package description'.
	package := (project createPackageNamed: 'Foo')
		description: description.
	
	self 
		assertCollection: project packageNames
		hasSameElements: #('Foo').
		
	self
		assert: (project packageNamed: 'Foo') description
		equals: description.
]

{ #category : #tests }
PBProjectCreationTest >> testCanImportPackageInProjectAndSetDescription [

	| description |
	description := 'Foo package description'.
	(project importPackageNamed: 'Foo')
		description: description.
	
	self 
		assertCollection: project packageNames
		hasSameElements: #('Foo').
		
	self
		assert: (project packageNamed: 'Foo') description
		equals: description
]

{ #category : #tests }
PBProjectCreationTest >> testCanImportPackagesInProject [

	project importPackagesNamed: #('Foo' 'Bar').
	
	self 
		assertCollection: project packageNames
		hasSameElements: #('Foo' 'Bar')
]

{ #category : #tests }
PBProjectCreationTest >> testCanSetProjectRepository [

	| repository |
	repository := PBGitRepositoryCreator new
		url: 'https://github.com/pharo-pkg/pharo-counter.git';
		version: 'master';
		create.
	project repository: repository.
	
	
	self assert: project repository repositoryUrl equals: 'https://github.com/pharo-pkg/pharo-counter.git'.
	self assert: project repository version equals: 'master'
]
