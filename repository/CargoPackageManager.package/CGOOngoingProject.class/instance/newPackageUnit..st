updating
newPackageUnit: aCGOPackageUnitName
	| unitName |
	
	unitName := aCGOPackageUnitName asSymbol.
	unitNames add: unitName.
	^ CGOPackageRegistry default register: (CGOOngoingPackageUnit for: unitName in: name)