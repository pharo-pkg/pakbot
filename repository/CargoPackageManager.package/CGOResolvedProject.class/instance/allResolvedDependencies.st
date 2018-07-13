accessing
allResolvedDependencies
	
	| indirectDependencies |
	indirectDependencies := self resolvedDependencies
		flatCollect: [ :each | each resolution allResolvedDependencies ].
	^ self resolvedDependencies, indirectDependencies