tests
testCanDetectGitRepositoryNotClonedWhenMissingLocation

	| repo |
	repo := self pharoCounterMaster.
	self deny: repo isCloned
