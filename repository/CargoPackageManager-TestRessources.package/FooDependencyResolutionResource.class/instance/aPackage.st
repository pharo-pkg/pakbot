packages
aPackage
	^ CGOPackageUnit newFrom: { 
		#package -> #A .
		#version -> '1.0' .
		#dependencies -> { #B -> #('=3.1') . #C -> #('=1.0') }
	} asDictionary