compute - clustering
topGroups
	^ self groupCandidates collect: 
		[ :each |
		each -> (self imageDependencies values sum: 
			[ :aDependencySet | (aDependencySet includesAll: each) ifTrue: [ 1 ] ifFalse: [ 0 ] ]) ]