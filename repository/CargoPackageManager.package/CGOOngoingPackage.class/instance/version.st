compatibility - cargo solver
version
	| vcsCommitish |
	vcsCommitish := self repository currentCommitId.
	^ SemanticVersion fromString: '0-' , vcsCommitish
