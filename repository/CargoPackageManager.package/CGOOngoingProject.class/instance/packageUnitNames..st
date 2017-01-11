updating
packageUnitNames: aListOfPackageNames 
	unitNames := aListOfPackageNames 
		collect: #asSymbol
		as: Set