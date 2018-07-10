tests
testProjectIsNotUpToDate

	self deny: project isUpToDate.
	self assert: project hasProblems.