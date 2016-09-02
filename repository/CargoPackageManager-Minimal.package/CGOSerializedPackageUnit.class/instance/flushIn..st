deserialization
flushIn: aPackageUnit
	super flushIn: aPackageUnit.
	aPackageUnit 
		instVarNamed: 'repositories' put: self deserializeRepositories;
		instVarNamed: 'authors' put: (self toArrayOrNilIfEmpty: authors);
		instVarNamed: 'contributors' put: (self toArrayOrNilIfEmpty: contributors);
		instVarNamed: 'platformRequirements' put: (self toArray: platformRequirements);
		instVarNamed: 'provisions' put: (self toArray: provisions);
		instVarNamed: 'file' put: file.
	self deserializeDependenciesIn: aPackageUnit