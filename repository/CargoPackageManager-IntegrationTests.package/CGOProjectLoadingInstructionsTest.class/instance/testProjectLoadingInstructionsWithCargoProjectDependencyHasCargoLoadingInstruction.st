tests
testProjectLoadingInstructionsWithCargoProjectDependencyHasCargoLoadingInstruction

	| testRegistry resolution projectOne dependency |
	testRegistry := CGOPackageRegistry new.	
	projectOne := testRegistry newProjectNamed: 'Test'.
	
	dependency := CGOCargoProjectDependency
		named: 'test-project-source-properties-tonel'
		repositoryUrl: 'git@github.com:pharo-vcs/test-project-source-properties-tonel.git'.
	projectOne addDependency: dependency.
	resolution := projectOne resolve.

	"Since the project and its dependencies are already loaded and up to date,
	the calculated load instructions should strip out all installed things and then be empty"
	self assert: resolution loadInstructions size equals: 1.
	self assert: (resolution loadInstructions includes: self expectedCargoResolvedProject)