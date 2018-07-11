tests
testProjectLoadingInstructionsWithMetacelloProjectDependencyHasMetacelloLoadingInstruction

	| testRegistry resolution projectOne configurationProject |
	testRegistry := CGOPackageRegistry new.	
	projectOne := testRegistry newProjectNamed: 'Test'.
	
	configurationProject := CGOMetacelloConfigurationProject
		configuration: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.
	
	projectOne addDependency: configurationProject.
	resolution := projectOne resolution.

	"Since the project and its dependencies are already loaded and up to date,
	the calculated load instructions should strip out all installed things and then be empty"
	self assert: resolution loadInstructions size equals: 1.
	self assert: (resolution loadInstructions includes: configurationProject)