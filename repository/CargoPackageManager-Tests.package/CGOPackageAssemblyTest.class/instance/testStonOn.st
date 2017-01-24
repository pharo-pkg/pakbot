tests
testStonOn
	| assembly |
	assembly := self assemblyA1.
	assembly
		instVarNamed: 'timestamp'
		put:
			(DateAndTime
				fuzzyReadFrom: '2015-02-26T12:17:20.505912+01:00' readStream).
	self
		assert: (CGOPackageVersionWriter toStringPretty: assembly)
		equals: self expectedTestStonOnResult