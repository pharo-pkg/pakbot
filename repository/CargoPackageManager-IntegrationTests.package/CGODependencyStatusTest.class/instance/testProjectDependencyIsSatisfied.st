tests
testProjectDependencyIsSatisfied

	self installProject.
	self assert: dependencyToProject isInstalled.