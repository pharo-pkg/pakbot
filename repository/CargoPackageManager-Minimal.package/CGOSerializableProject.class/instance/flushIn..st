deserialization
flushIn: aCGOProject
	"Flush information from this SerializableProject into the provided CGOProject.
	All instance variables will be set with values from the SerializableProject"
	name isNil
		ifTrue: [ CGOPackageManagerError new 
						signal: 'Cannot deserialize a Project with no package or version defined!' ].	
	aCGOProject 
	"name description repository version unitNames assemblies authors"
		instVarNamed: 'name' put: name;
		instVarNamed: 'version' put: (SemanticVersion fromString: version);
		instVarNamed: 'description' put: description;
		instVarNamed: 'repository' put: repository;
		instVarNamed: 'unitNames' put: (self toArray: unitNames);
		instVarNamed: 'assemblies' put: (self toArray: assemblies);
		instVarNamed: 'virtualPackages' put: (self toArray: virtualPackages);
		instVarNamed: 'authors' put: (self toArray: authors);
		yourself.
