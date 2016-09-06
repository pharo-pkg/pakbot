packages
dPackage
	^ CGOPackageUnit newFrom: { 
		#package -> #D .
		#version -> '1.1' .
		#dependencies -> { #B -> #('=3.1') }
	} asDictionary