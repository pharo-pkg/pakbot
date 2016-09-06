compute - clustering
groupCandidates
	^ self imageDependencies values 
		flatCollect: [ :each | self groupCandidatesFor: each ]
		as: Set 