tests
testFromSton
	| seasideCore ston |
	seasideCore := self packageVersions detect: [ :each | each packageName = 'Seaside-Core' ].
	ston := CGOPackageVersionWriter toStringPretty: seasideCore.
	self
		assert: (CGOPackageVersionReader fromString: ston)
		equals: seasideCore