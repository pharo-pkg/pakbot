tests
testProjectIsUpToDate

	self installProject.
	self assert: project isUpToDate.
	self deny: project hasProblems.