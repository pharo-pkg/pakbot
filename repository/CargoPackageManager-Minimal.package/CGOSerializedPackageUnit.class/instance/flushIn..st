deserialization
flushIn: aPackageUnit
	super flushIn: aPackageUnit.
	aPackageUnit 
		instVarNamed: 'src' put: src;
		instVarNamed: 'authors' put: (self toArrayOrNilIfEmpty: authors);
		instVarNamed: 'contributors' put: (self toArrayOrNilIfEmpty: contributors);
		instVarNamed: 'platformRequirements' put: (self toArray: platformRequirements);
		instVarNamed: 'provisions' put: (self toArray: provisions).
	self deserializeDependenciesIn: aPackageUnit