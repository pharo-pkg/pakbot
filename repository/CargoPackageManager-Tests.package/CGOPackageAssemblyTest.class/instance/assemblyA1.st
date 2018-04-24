test data
assemblyA1
	| dictionary |
	dictionary := Dictionary
		with: #package -> #A
		with:
			#parts
				->
					{(#B -> #()).
					(#C -> #('=1.1'))}
		with: #project -> self project.
	^ CGOPackageVersion newFrom: dictionary