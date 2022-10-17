Class {
	#name : #PBCatalogIntegrationTest,
	#superclass : #PBAbstractTest,
	#instVars : [
		'packageRepository'
	],
	#category : #'Pakbot-Catalog-Tests'
}

{ #category : #tests }
PBCatalogIntegrationTest >> setUp [
	super setUp.
	packageRepository := PBPackageRepository newLocalRepositoryIn: FileSystem memory root.

]

{ #category : #tests }
PBCatalogIntegrationTest >> testCanLoadProjectFromProjectPublishedInPackageRepository [
	| publishedProject |
	packageRepository := self testCanLoadProjectFromScmAndPublishItToPackageRepository.
	
	publishedProject := packageRepository fetch: #PharoCounter version: '0.1' asSemanticVersion.
	publishedProject registry: PBPackageRegistry new.
	publishedProject load.
	
	self assert: (Smalltalk globals hasClassNamed: 'Counter').
	self assert: publishedProject isInstalled.
]

{ #category : #tests }
PBCatalogIntegrationTest >> testCanLoadProjectFromScmAndPublishItToPackageRepository [
	| repository project publishedProject |
	repository := PBGitRepositoryCreator new
		url: 'https://github.com/pharo-pkg/pharo-counter.git';
		version: 'master';
		create.		
	project := PBProjectVersion fromRepository: repository.
	
	project 
		registry: PBPackageRegistry new;
		version: '0.1' asSemanticVersion.
	project publishOn: packageRepository.
	
	publishedProject := packageRepository fetch: project name version: project version.
	
	self
		assert: publishedProject
		equals: project.
		
	^ packageRepository 
]

{ #category : #tests }
PBCatalogIntegrationTest >> testGetSameResolutionWhenSolvingAProjectFromPackageRepositoryOrInImageProject [
	| project resolution fetchedproject resolution2 |
	
	"Solve project"
	project := PharoLauncherProject new
		buildWithoutPackageDependencyAndRegisterIn: testRegistry;
		buildRepository.
	resolution := testRegistry newSolver solveProject: project.
	resolution conflicts do: [ :conflict | conflict resolveWithAlreadyInstalled ].

	"Publish Pharo Launcher 1.7.2"
	project version: '1.7.2' asSemanticVersion.
	[ project publishOn: packageRepository ]
		on: PBProjectHasConflictsError 
		do: [ :e | e conflicts do: #resolveWithAlreadyInstalled. e resume ].

	"Fetch and solve published project"
	fetchedproject := packageRepository fetch: 'PharoLauncher' version: '1.7.2'.
	fetchedproject registry: testRegistry.
	resolution2 := fetchedproject resolve.
	resolution2 conflicts do: [ :conflict | conflict resolveWithAlreadyInstalled ].

	self assert: resolution equals: resolution2.
	"self assert: resolution loadInstructions = resolution2 loadInstructions"
]
