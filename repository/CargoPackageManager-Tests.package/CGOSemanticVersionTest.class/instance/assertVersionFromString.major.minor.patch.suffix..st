helpers
assertVersionFromString: aString major: major minor: minor patch: patch suffix: suffix
	| version |
	
	version := SemanticVersion fromString: aString.
	self assert: version isNotNil.
	self assert: version major equals: major.
	self assert: version minor equals: minor.
	self assert: version patch equals: patch.
	self assert: version suffix equals: suffix.