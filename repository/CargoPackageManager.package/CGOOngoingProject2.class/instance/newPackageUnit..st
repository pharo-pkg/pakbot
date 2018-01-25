updating
newPackageUnit: aCGOPackageUnitName
	| unit |
	
	unit := CGOOngoingPackageUnit2 
		for: aCGOPackageUnitName asSymbol
		project: self.
	^ units add: unit