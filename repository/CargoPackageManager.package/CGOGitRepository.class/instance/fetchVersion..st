fetching
fetchVersion: aString
	
	| commitish project |
	self ensureCloned.
	
	commitish := aString
		ifEmpty: [ iceRepository headCommit ]
		ifNotEmpty: [ iceRepository revparse: aString ].


	project := CGOOngoingProject named: commitish project projectName.
	project repository: self.
	project version: (SemanticVersion fromString: '0-' , (aString ifEmpty: ['N/A'])).
	^ project