tests
testStonOn
	| seasideCore |
	seasideCore := self packageVersions detect: [ :each | each packageName = 'Seaside-Core' ].
	seasideCore 
		instVarNamed: 'timestamp'
		put: (DateAndTime fuzzyReadFrom: '2015-02-26T12:17:20.505912+01:00' readStream).
		
	self
		assert: (CGOPackageVersionWriter toStringPretty: seasideCore)
		equals: self seasideCore310StonString