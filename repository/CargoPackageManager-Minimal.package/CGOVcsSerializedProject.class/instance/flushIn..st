deserialization
flushIn: aCGOOngoingProject
	"Flush information from this SerializableProject into the provided CGOProject.
	All instance variables will be set with values from the SerializableProject"
	name isNil
		ifTrue: [ CGOPackageManagerError new 
						signal: 'Cannot deserialize a Project with no package defined!' ].	
	aCGOOngoingProject 
		initializeWithPackageName: name andProject: nil;
		description: description;
		packageUnits: ((self toArray: units) collect: #asOngoingPackage as: Set);
		assemblies: ((self toArray: assemblies) collect: #asOngoingPackage as: Set);
		virtualPackages: ((self toArray: virtualPackages) collect: #asOngoingPackage as: Set);
		externalProjects: (self toDictionary: externalProjects).
		
	aCGOOngoingProject packages do: [:package | package project: aCGOOngoingProject ]