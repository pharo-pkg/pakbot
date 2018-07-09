private
isBranch: commitish
	^ iceRepository allBranches
		anySatisfy: [ :branch | branch name = commitish or: [ branch name endsWith: '/' , commitish ] ]