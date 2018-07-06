test data
assemblyFoo
	| dictionary |
	dictionary := Dictionary
		with: #package -> #Foo
		with: #version -> '1.0'
		with: #parts -> { #bar -> #() .
								#baz -> #('=1.1') }.
	^ CGOPackageVersion newFrom: dictionary
