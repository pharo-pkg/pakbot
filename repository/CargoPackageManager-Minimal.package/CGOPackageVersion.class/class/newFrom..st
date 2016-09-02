instance creation
newFrom: aDictionary
	^ (aDictionary
			at: #parts
			ifPresent: [ :v | CGOPackageAssembly ]
			ifAbsent: [ CGOPackageUnit ])
				new
				initializeFrom: aDictionary