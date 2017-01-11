updating
newPackageUnit: aCGOPackageUnitName
	| unitName |
	
	unitName := aCGOPackageUnitName asSymbol.
	unitNames add: unitName.
	^ CGOPackageRegistry default register: (CGOOngoingPackageUnit2 for: unitName in: name)