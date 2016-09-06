tests
testStonOn
	| dictionary assembly |
	dictionary := Dictionary
		with: #package -> #A
		with: #version -> '1.0'
		with: #parts -> { #B -> #() .
							 #C -> #('=1.1') }.
	assembly := CGOPackageVersion newFrom: dictionary.
	assembly 
		instVarNamed: 'timestamp'
		put: (DateAndTime fuzzyReadFrom: '2015-02-26T12:17:20.505912+01:00' readStream).

	self
		assert: (CGOPackageVersionWriter toStringPretty: assembly)
		equals: self expectedTestStonOnResult 