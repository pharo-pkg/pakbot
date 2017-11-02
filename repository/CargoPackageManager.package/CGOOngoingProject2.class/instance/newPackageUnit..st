updating
newPackageUnit: aCGOPackageUnitName
	| unitName |
	
	unitName := aCGOPackageUnitName asSymbol.
	unitNames add: unitName.
	^ registry register: (CGOOngoingPackageUnit for: unitName in: name)