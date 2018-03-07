updating
newPackageUnit: aCGOPackageUnitName
	| unit |
	
	unit := CGOOngoingPackageUnit 
		for: aCGOPackageUnitName asSymbol
		project: self.
	(units includes: unit)
		ifTrue: [ CGOPackageAlreadyRegistered signal ].
	units add: unit.
	^ registry register: unit