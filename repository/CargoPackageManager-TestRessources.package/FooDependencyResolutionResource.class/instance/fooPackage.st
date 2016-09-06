packages
fooPackage
	^ CGOPackageUnit newFrom: { 
		#package -> #Foo .
		#version -> '1.0' .
		#parts -> { #A -> #('=1.0') . #E -> #('=1.0') }
	} asDictionary