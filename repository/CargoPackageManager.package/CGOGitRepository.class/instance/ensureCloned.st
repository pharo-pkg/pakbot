actions
ensureCloned
	| commitish |
	self isCloned
		ifFalse: [ iceRepository := iceRepository createRepository ].

	commitish := version ifNil: [ 'master' ].
	(self isBranch: commitish)
		ifTrue: [ self syncBranchWithOrigin: commitish ]
		ifFalse: [ self syncToCommitish: commitish ].
		
	[ iceRepository register ]
		on: IceDuplicatedRepository 
		do: [ "reposiotry already added to Iceberg. Ignore the warning and do not add it again." ] 