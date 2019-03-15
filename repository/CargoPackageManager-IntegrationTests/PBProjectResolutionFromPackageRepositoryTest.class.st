"
I test that project resolution from a package repository gives same results as a project resolution in image (metadata already loaded).
"
Class {
	#name : #PBProjectResolutionFromPackageRepositoryTest,
	#superclass : #PBAbstractTest,
	#category : #'CargoPackageManager-IntegrationTests'
}

{ #category : #tests }
PBProjectResolutionFromPackageRepositoryTest >> testGetSameResolutionWhenSolvingAProjectFromPackageRepositoryOrInImageProject [
	| project resolution pkgRepo fetchedproject resolution2 |
	
	"Solve project"
	project := PharoLauncherProject new
		buildWithoutPackageDependencyAndRegisterIn: testRegistry;
		buildRepository.
	resolution := testRegistry newSolver solveProject: project.
	resolution conflicts do: [ :conflict | conflict resolveWithAlreadyInstalled ].

	"Publish Pharo Launcher 1.7.2"
	project version: '1.7.2' asSemanticVersion.
	pkgRepo := PBPackageRepository newLocalRepositoryIn: FileSystem memory root.
	[ project publishOn: pkgRepo ]
		on: PBProjectHasConflictsError 
		do: [ :e | e conflicts do: #resolveWithAlreadyInstalled. e resume ].

	"Fetch and solve published project"
	fetchedproject := pkgRepo fetch: 'PharoLauncher' version: '1.7.2'.
	fetchedproject registry: testRegistry.
	resolution2 := fetchedproject resolve.
	resolution2 conflicts do: [ :conflict | conflict resolveWithAlreadyInstalled ].

	self assert: resolution equals: resolution2.
	"self assert: resolution loadInstructions = resolution2 loadInstructions"
]
