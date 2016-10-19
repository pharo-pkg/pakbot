tests
testFromSton
	| seasideCore ston |
	seasideCore := self packageVersions detect: [ :each | each packageName = 'Seaside-Core' ].
	ston := CGOPackageVersionWriter toStringPretty: seasideCore.
	self
		assert: (STON fromString: ston)
		equals: seasideCore