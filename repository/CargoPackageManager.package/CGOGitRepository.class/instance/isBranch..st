private
isBranch: commitish
	^ iceRepository localBranches
		anySatisfy: [ :branch | branch name = commitish ]