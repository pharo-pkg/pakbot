compatibility - cargo solver
version
	| vcsCommitish |
	vcsCommitish := self repository 
		ifNil: [ 'N/A' ]
		ifNotNil: [ self repository currentCommitId ].
	^ SemanticVersion fromString: '0-' , vcsCommitish
