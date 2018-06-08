private
syncToCommitish: commitish
	iceRepository headCommit = commitish
		ifFalse: [ (iceRepository lookupCommit: commitish) checkout ]