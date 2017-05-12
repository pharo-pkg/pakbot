execution
execute
	project newPackageUnit: unitName.
	SycAddNewPackageCommand new
		systemEnvironment: toolContext systemEnvironment;
		packageName: unitName;
		execute.
	self refreshCalypso