test data
assemblyA1
	| dictionary |
	dictionary := Dictionary
		with: #package -> #A
		with: #version -> '1.0'
		with:
			#parts
				->
					{(#B -> #()).
					(#C -> #('=1.1'))}
		with: #projectName -> #'MyProject'.
	^ CGOPackageVersion newFrom: dictionary