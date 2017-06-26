tests
testEmptyEnvironmentFitsRequirements
	self assert: (CGOEnvironment new fitsRequirementsOf: self pharo60Environment)