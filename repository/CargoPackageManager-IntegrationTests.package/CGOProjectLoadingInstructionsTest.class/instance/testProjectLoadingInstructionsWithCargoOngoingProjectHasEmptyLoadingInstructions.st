tests
testProjectLoadingInstructionsWithCargoOngoingProjectHasEmptyLoadingInstructions

	| testRegistry resolution projectOne |
	testRegistry := CGOPackageRegistry new.
	
	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	projectOne addDependency: (CGOCargoProjectDependency
		named: 'ProjectTwo'
		version: '=0.0.0-N/A').
		
	testRegistry newProjectNamed: 'ProjectTwo'.
	resolution := projectOne resolution.

	"Since the project and its dependencies are already loaded and up to date,
	the calculated load instructions should strip out all installed things and then be empty"
	self assert: resolution loadInstructions isEmpty