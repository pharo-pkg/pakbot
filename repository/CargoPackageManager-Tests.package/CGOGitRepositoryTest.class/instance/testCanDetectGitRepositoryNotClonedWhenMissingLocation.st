tests
testCanDetectGitRepositoryNotClonedWhenMissingLocation
	| repository |
	repository := self pharoCounterMaster.
	self deny: repository isCloned
