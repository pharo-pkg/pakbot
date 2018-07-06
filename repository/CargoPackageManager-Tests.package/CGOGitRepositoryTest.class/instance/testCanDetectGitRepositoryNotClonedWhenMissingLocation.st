tests
testCanDetectGitRepositoryNotClonedWhenMissingLocation

	repository := self pharoCounterMaster.
	self deny: repository isCloned
