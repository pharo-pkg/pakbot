packages
bPackage
	^ CGOPackageUnit newFrom: { 
		#package -> #B .
		#version -> '3.1' .
		#dependencies -> { #D -> #('=1.1') }
	} asDictionary