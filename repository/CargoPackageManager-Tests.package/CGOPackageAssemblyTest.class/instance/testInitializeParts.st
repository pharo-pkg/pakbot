tests
testInitializeParts
	| dictionary assembly |
	dictionary := Dictionary
		with: #package -> #A
		with: #version -> '1.0'
		with: #parts -> { #foo -> #('=1.1') .
								#bar -> #('=2.0') }.
	assembly := CGOPackageVersion newFrom: dictionary.
	self
		assert: assembly parts first
		equals: (CGOPackageDependency newFrom: #foo -> #('=1.1'))