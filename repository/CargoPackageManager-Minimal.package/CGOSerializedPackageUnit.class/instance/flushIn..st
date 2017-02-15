deserialization
flushIn: aPackageUnit
	super flushIn: aPackageUnit.
	aPackageUnit 
		instVarNamed: 'src' put: src;
		instVarNamed: 'platformRequirements' put: (self toArray: platformRequirements);
		instVarNamed: 'provisions' put: (self toArray: (CGOPackageUnit provisionsFromListOfProvisionStrings: provisions)).
	self deserializeDependenciesIn: aPackageUnit