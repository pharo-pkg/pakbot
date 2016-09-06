tests
testParseValueWithAssociation
	| reader |
	reader := CGOPackageVersionReader new on: '''a'' : 1' readStream.
	self assert: reader parseValue equals: 'a' -> 1