actions
ensureCloned
	| commitish |
	self isCloned
		ifFalse: [ iceRepository := iceRepository createRepository ].

	commitish := version ifNil: [ 'master' ].
	(self isBranch: commitish)
		ifTrue: [ self syncBranchWithOrigin: commitish ]
		ifFalse: [ self syncToCommitish: commitish ]