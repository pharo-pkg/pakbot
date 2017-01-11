accessing
packageUnits
	^ unitNames collect: [ :unitName |
		CGOPackageRegistry default packageNamed: unitName ]
